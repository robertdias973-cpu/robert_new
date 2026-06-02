class Treino {
  final String id;
  final String nome;

  Treino({
    required this.id,
    required this.nome,
  });

  factory Treino.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Treino(
      id: id,
      nome: map['nome'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
    };
  }
}