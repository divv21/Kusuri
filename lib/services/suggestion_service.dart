import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MedicineSuggestion {
  final String name;
  final int defaultDosagePerDay;
  final int defaultDurationDays;
  final String timing;

  MedicineSuggestion({
    required this.name,
    required this.defaultDosagePerDay,
    required this.defaultDurationDays,
    required this.timing,
  });

  factory MedicineSuggestion.fromJson(Map<String, dynamic> json) {
    return MedicineSuggestion(
      name: json['name'],
      defaultDosagePerDay: json['defaultDosagePerDay'],
      defaultDurationDays: json['defaultDurationDays'],
      timing: json['timing'],
    );
  }
}

class SuggestionService {
  List<MedicineSuggestion> _suggestions = [];

  Future<void> loadSuggestions() async {
    final jsonStr = await rootBundle.loadString('assets/medicines.json');
    final List data = json.decode(jsonStr);
    _suggestions =
        data.map((e) => MedicineSuggestion.fromJson(e)).toList();
  }

  List<MedicineSuggestion> getSuggestions(String query) {
    return _suggestions
        .where((s) =>
        s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  MedicineSuggestion? findClosestMatch(String scannedName) {
    for (var s in _suggestions) {
      if (s.name.toLowerCase() == scannedName.toLowerCase()) {
        return s;
      }
    }
    return null;
  }
}
