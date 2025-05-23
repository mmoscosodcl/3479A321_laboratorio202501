class Activity {
  final int id;
  final DateTime date;
  final String name;

  Activity({
    required this.id,
    required this.date,
    required this.name,
  });

  // Convert Activity to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'name': name,
    };
  }

  // Create Activity from Map
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'],
      date: DateTime.parse(map['date']),
      name: map['name'],
    );
  }

}