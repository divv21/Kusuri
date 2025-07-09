import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kusuri/models/medicine.dart';


class LocalStorage {
  static const String _key = 'medicines';

  static Future<List<Medicine>> loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final decoded = json.decode(data) as List;
    return decoded.map((e) => Medicine.fromJSON(e)).toList();
  }
  static Future<void> saveMedicines(List<Medicine> meds) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(meds.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}