class Exercise {
  String? id;
  String name;
  String category;
  int sets;
  int reps;

  Exercise({
    this.id,
    required this.name,
    required this.category,
    required this.sets,
    required this.reps,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'sets': sets,
      'reps': reps,
    };
  }

  factory Exercise.fromMap(String id, Map<String, dynamic> map) {
    return Exercise(
      id: id,
      name: map['name'],
      category: map['category'],
      sets: map['sets'],
      reps: map['reps'],
    );
  }
}