class Medicine {
  final String name;
  final int dosagePerDay;
  final int durationDays;
  final String timing;

  Medicine({
    required this.name,
    required this.dosagePerDay,
    required this.durationDays,
    required this.timing,
});

  factory Medicine.fromJSON(Map<String, dynamic> json) => Medicine(
      name: json['name'],
      dosagePerDay: json['dosagePerDay'],
      durationDays: json['durationDays'],
      timing: json['timing'],
  );
  Map<String, dynamic> toJson() => {
    'name': name,
    'dosagePerDay': dosagePerDay,
    'durationDays': durationDays,
    'timing': timing,
  };
}