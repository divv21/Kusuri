import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kusuri/viewmodels/medicine_viewmodel.dart';

import 'add_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =Provider.of<MedicineViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Kusuri"), centerTitle: true,),
      body: viewModel.medicines.isEmpty
      ? Center(child: Text('No medicines yet'))
      : ListView.builder(
        itemCount: viewModel.medicines.length,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemBuilder: (context, index) {
          final med = viewModel.medicines[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.medication, color: Color(0xFF2E7D32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(med.name, style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF2E7D32),
                      )),
                      const SizedBox(height: 4),
                      Text('${med.dosagePerDay}x/day • ${med.durationDays} days • ${med.timing}',
                        style: const TextStyle(color: Color(0xFF757575), fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF2E7D32)),
              ],
            ),
          );
        },
      )
      ,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newMed = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddMedicineScreen()),
            );
            if (newMed != null) {
              viewModel.addMedicine(newMed);
            }
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}


