import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final picked = await picker.pickImage(source: ImageSource.camera);
                      if (picked != null) {
                        await vm.scanMedicineName(File(picked.path));
                        _nameController.text = vm.scannedName ?? '';
                      }
                    },
                  ),
                ),
                validator: (val) =>
                val == null || val.trim().isEmpty ? 'Enter a name' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: dosagePerDay,
                decoration: InputDecoration(labelText: 'Dosage Per Day'),
                items: [1, 2, 3, 4]
                    .map((e) => DropdownMenuItem(child: Text('$e'), value: e))
                    .toList(),
                onChanged: (val) => setState(() => dosagePerDay = val ?? 1),
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
                onSaved: (val) =>
                durationDays = int.tryParse(val ?? '1') ?? 1,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: timing,
                decoration: InputDecoration(labelText: 'Timing'),
                items: ['Before Food', 'After Food']
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (val) =>
                    setState(() => timing = val ?? 'Before Food'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
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
