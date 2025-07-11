import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
import '../services/reminder_service.dart';
import '../viewmodels/add_medicine_viewmodel.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  int dosagePerDay = 1;
  int durationDays = 1;
  String timing = 'Before Food';

  final List<TimeOfDay> fixedTimeSlots = const [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 20, minute: 0),
  ];

  List<TimeOfDay> selectedTimes = [];

  @override
  void initState() {
    super.initState();
    final scannedName = context.read<AddMedicineViewModel>().scannedName;
    _nameController = TextEditingController(text: scannedName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddMedicineViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Add Medicine')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
                  return vm.suggestionService
                      .getSuggestions(textEditingValue.text)
                      .map((e) => e.name);
                },
                onSelected: (String selection) {
                  final match = vm.suggestionService.findClosestMatch(selection);
                  if (match != null) {
                    setState(() {
                      _nameController.text = match.name;
                      dosagePerDay = match.defaultDosagePerDay;
                      durationDays = match.defaultDurationDays;
                      timing = match.timing;
                      selectedTimes.clear(); // Clear previous selections
                    });
                  }
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  // Don’t override _nameController if already set
                  controller.text = _nameController.text;
                  return TextFormField(
                    controller: _nameController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Medicine Name',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
                          final picker = ImagePicker();
                          final picked = await picker.pickImage(source: ImageSource.camera);
                          if (picked != null) {
                            await vm.scanMedicineName(File(picked.path));
                            final scanned = vm.scannedName ?? '';
                            setState(() {
                              _nameController.text = scanned;
                            });
                          }
                        },
                      ),
                    ),
                    validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter a name' : null,
                  );
                },
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: dosagePerDay,
                decoration: InputDecoration(labelText: 'Dosage Per Day'),
                items: [1, 2, 3, 4]
                    .map((e) => DropdownMenuItem(child: Text('$e'), value: e))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    dosagePerDay = val ?? 1;
                    selectedTimes.clear(); // Reset times when dosage changes
                  });
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration (days)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  final parsed = int.tryParse(val ?? '');
                  if (parsed == null || parsed <= 0) return 'Enter a valid number';
                  return null;
                },
                onSaved: (val) => durationDays = int.tryParse(val ?? '1') ?? 1,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: timing,
                decoration: InputDecoration(labelText: 'Timing'),
                items: ['Before Food', 'After Food']
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (val) => setState(() => timing = val ?? 'Before Food'),
              ),
              SizedBox(height: 16),
              Text('Select Reminder Times:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: fixedTimeSlots.map((time) {
                  final isSelected = selectedTimes.contains(time);
                  final timeStr = time.format(context);
                  return ChoiceChip(
                    label: Text(timeStr),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          if (selectedTimes.length < dosagePerDay) {
                            selectedTimes.add(time);
                          }
                        } else {
                          selectedTimes.remove(time);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Add'),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (selectedTimes.length != dosagePerDay) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select $dosagePerDay time slots'),
                        ),
                      );
                      return;
                    }

                    _formKey.currentState?.save();

                    final medName = _nameController.text.trim();
                    final newMed = Medicine(
                      name: medName,
                      dosagePerDay: dosagePerDay,
                      durationDays: durationDays,
                      timing: timing,
                    );

                    vm.clearScan();
                    Navigator.pop(context, newMed);

                    await NotificationService.scheduleFixedTimeReminders(
                      medName: newMed.name,
                      times: selectedTimes,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
