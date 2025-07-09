import 'package:kusuri/models/medicine.dart';
import 'package:kusuri/repositories/medicine_repository.dart';

import '../data/local_storage.dart';

class LocalMedicineRepository implements MedicineRepository {
  @override
  Future<List<Medicine>> getMedicines() => LocalStorage.loadMedicines();

  @override
  Future<void> saveMedicines(List<Medicine> medicines) =>
      LocalStorage.saveMedicines(medicines);
}