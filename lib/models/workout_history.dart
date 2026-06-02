class WorkoutHistory {
  final String date;
  final Map<String, int> exercises;
  final bool completed;

  WorkoutHistory({
    required this.date,
    required this.exercises,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'exercises': exercises,
      'completed': completed,
    };
  }
}