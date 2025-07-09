import '../models/medicine.dart';

abstract class MedicineRepository {
  Future<List<Medicine>> getMedicines();
  Future<void> saveMedicines(List<Medicine> medicines);
}