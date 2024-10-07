import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_escolar_aluno/constants.dart';
import 'package:http/http.dart' as http;

class TurmaService {
    final turmas = FirebaseFirestore.instance.collection('turmas');
  Stream<QuerySnapshot<Map<String, dynamic>>> getTurmas(String professorId) {
    final data = turmas.where('professorId').snapshots();
    return data;
  }

  Future<void> addTurma({
    required String nome,
    required String escola,
    required String professorId,
  }) async {
    Map<String, dynamic> data = {
      'nome': nome,
      'escola': escola,
      'professorId': professorId,
    };
    return turmas.add(data);
  }

  static Future<void> removeTurma(String turmaId) async {
    final responseActivities = await http.get(
      Uri.parse('$apiUrl/atividades?turmaId=$turmaId'),
    );
    final List acitivitiesBody = jsonDecode(responseActivities.body);

    if (acitivitiesBody.isNotEmpty) {
      throw Exception('Esta turma possui atividades atribuidas a ela.');
    }

    final response = await http.delete(Uri.parse('$apiUrl/turmas/$turmaId'));


    if (response.statusCode != 200) {
      throw Exception('Could not delete turma.');
    }
  }
}
