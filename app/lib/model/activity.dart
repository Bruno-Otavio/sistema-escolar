class Activity {
  const Activity({
    required this.id,
    required this.descricao,
    required this.turmaId,
  });

  final String id;
  final String descricao;
  final String turmaId;

  factory Activity.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'descricao': String descricao,
        'turmaId': String turmaId,
      } =>
        Activity(
          id: id,
          descricao: descricao,
          turmaId: turmaId,
        ),
      _ => throw const FormatException('Could not get activity.'),
    };
  }
}
