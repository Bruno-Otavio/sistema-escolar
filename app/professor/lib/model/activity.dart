import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  const Activity({
    required this.id,
    required this.descricao,
    required this.turmaId,
    required this.timeStamp,
  });

  final String id;
  final String descricao;
  final String turmaId;
  final Timestamp timeStamp;

  factory Activity.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'descricao': String descricao,
        'turmaId': String turmaId,
        'timeStamp': Timestamp timeStamp,
      } =>
        Activity(
          id: id,
          descricao: descricao,
          turmaId: turmaId,
          timeStamp: timeStamp,
        ),
      _ => throw const FormatException('Could not get activity.'),
    };
  }
}
