import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScanService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String?> scanTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final recognizedText = await _textRecognizer.processImage(inputImage);

    final lines = recognizedText.text.split('\n');
    for (var line in lines) {
      if (line.contains(RegExp(r'[A-Za-z]+\s?\d{2,4}'))) {
        return line.trim();
      }
    }
    return lines.isNotEmpty ? lines.first.trim() : null;
  }

  void dispose() {
    _textRecognizer.close();
  }
}