import 'dart:convert';

import 'package:sistema_escolar_aluno/constants.dart';
import 'package:sistema_escolar_aluno/model/turma.dart';
import 'package:http/http.dart' as http;

class TurmaService {
  static Future<List<Turma>> getTurmas(String professorId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/turmas?professorId=$professorId'));

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => Turma.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch turmas.');
    }
  }

  static Future<void> addTurma({
    required String nome,
    required String escola,
    required String professorId,
  }) async {
    final Map<String, dynamic> data = {
      'nome': nome,
      'escola': escola,
      'professorId': professorId,
    };

    final response = await http.post(
      Uri.parse('$apiUrl/turmas'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Could not add turma.');
    }
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
