class Workout {
  String? id;
  String nome;

  Workout({
    this.id,
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
    };
  }

  factory Workout.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return Workout(
      id: id,
      nome: map['nome'] ?? '',
    );
  }
}