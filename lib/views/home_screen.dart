import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kusuri/viewmodels/medicine_viewmodel.dart';

import 'add_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =Provider.of<MedicineViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Kusuri")),
      body: viewModel.medicines.isEmpty
      ? Center(child: Text('No medicines yet'))
      : ListView.builder(
          itemCount: viewModel.medicines.length,
          itemBuilder: (context, index) {
            final med = viewModel.medicines[index];
            return ListTile(
              title: Text(med.name),
              subtitle: Text(
                '${med.dosagePerDay}x/day • ${med.durationDays} days • ${med.timing}',
              ),
            );
          },
      ),
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
        child: Icon(Icons.add),
      ),
    );
  }
}


