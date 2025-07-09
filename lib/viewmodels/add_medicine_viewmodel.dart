import 'dart:io';
import 'package:flutter/material.dart';
import '../services/scan_service.dart';

class AddMedicineViewModel extends ChangeNotifier {
  final ScanService scanService;

  AddMedicineViewModel({required this.scanService});

  String? scannedName;
  bool isScanning = false;

  Future<void> scanMedicineName(File imageFile) async {
    isScanning = true;
    notifyListeners();

    final result = await scanService.scanTextFromImage(imageFile);
    scannedName = result;

    isScanning = false;
    notifyListeners();
  }

  void clearScan() {
    scannedName = null;
    notifyListeners();
  }
}
