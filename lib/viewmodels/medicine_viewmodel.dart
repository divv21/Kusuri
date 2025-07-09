import 'package:flutter/material.dart';
import 'package:kusuri/repositories/medicine_repository.dart';

import '../models/medicine.dart';

class MedicineViewModel extends ChangeNotifier {
  final MedicineRepository repository;

  List<Medicine> _medicines = [];
  List<Medicine> get medicines => _medicines;

  MedicineViewModel({required this.repository});

  Future<void> loadMedicines() async {
    _medicines =  await repository.getMedicines();
    notifyListeners();
  }

  Future<void> addMedicine(Medicine medicine) async {
    _medicines.add(medicine);
    await repository.saveMedicines(_medicines);
    notifyListeners();
  }
}