class Turma {
  const Turma({
    required this.id,
    required this.nome,
    required this.professorId,
    required this.escola,
  });

  final String id;
  final String nome;
  final String professorId;
  final String escola;

  factory Turma.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'nome': String nome,
        'professorId': String professorId,
        'escola': String escola,
      } =>
        Turma(
          id: id,
          nome: nome,
          professorId: professorId,
          escola: escola,
        ),
      _ => throw const FormatException('Could not get turma.'),
    };
  }
}
