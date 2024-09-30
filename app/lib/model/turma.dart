class Turma {
  const Turma({
    required this.id,
    required this.nome,
    required this.professorId,
  });

  final String id;
  final String nome;
  final int professorId;

  factory Turma.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'nome': String nome,
        'professorId': int professorId,
      } =>
        Turma(
          id: id,
          nome: nome,
          professorId: professorId,
        ),
      _ => throw const FormatException('Could not get turma.'),
    };
  }
}
