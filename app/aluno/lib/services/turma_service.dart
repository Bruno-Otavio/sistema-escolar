import 'package:cloud_firestore/cloud_firestore.dart';

class TurmaService {
  final turmas = FirebaseFirestore.instance.collection('turmas');

  Stream<QuerySnapshot<Map<String, dynamic>>> getTurmas(String professorId) {
    final data = turmas.where('professorId', isEqualTo: professorId).snapshots();
    return data;
  }

  Future<void> addTurma({
    required String nome,
    required String escola,
    required String professorId,
  }) {
    Map<String, dynamic> data = {
      'nome': nome,
      'escola': escola,
      'professorId': professorId,
    };
    return turmas.add(data);
  }

  Future<void> removeTurma(String turmaId) {
    return turmas.doc(turmaId).delete();
  }
}
