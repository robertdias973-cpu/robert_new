class Exercise {
  String? id;
  String nome;
  int series;
  int repeticoes;
  double carga;

  Exercise({
    this.id,
    required this.nome,
    required this.series,
    required this.repeticoes,
    required this.carga,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'series': series,
      'repeticoes': repeticoes,
      'carga': carga,
    };
  }

  factory Exercise.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return Exercise(
      id: id,
      nome: map['nome'],
      series: map['series'],
      repeticoes: map['repeticoes'],
      carga: (map['carga'] as num).toDouble(),
    );
  }
}