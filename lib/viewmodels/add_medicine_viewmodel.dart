import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kusuri/services/suggestion_service.dart';
import '../services/scan_service.dart';

class AddMedicineViewModel extends ChangeNotifier {
  final ScanService scanService;
  final SuggestionService suggestionService;

  AddMedicineViewModel({
    required this.scanService,
    required this.suggestionService,

  });

  String? scannedName;
  bool isScanning = false;

  int dosagePerDay = 1;
  int durationDays = 1;
  String timing = 'Before Food';

  Future<void> scanMedicineName(File imageFile) async {
    isScanning = true;
    notifyListeners();

    final result = await scanService.scanTextFromImage(imageFile);
    scannedName = result;

    final match = suggestionService.findClosestMatch(scannedName ?? '');
    if (match != null) {
      dosagePerDay = match.defaultDosagePerDay;
      durationDays = match.defaultDurationDays;
      timing = match.timing;

      isScanning = false;
      notifyListeners();
    }
  }
  void clearScan() {
    scannedName = null;
    dosagePerDay = 1;
    durationDays = 1;
    timing = 'Before Food';
    notifyListeners();
  }
}
