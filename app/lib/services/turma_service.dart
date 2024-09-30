import 'dart:convert';

import 'package:sistema_escolar/constants.dart';
import 'package:sistema_escolar/model/turma.dart';
import 'package:http/http.dart' as http;

class TurmaService {
  static Future<List<Turma>> getTurmas(String professorId) async {
    final response = await http.get(Uri.parse('$apiUrl/turmas?professorId=$professorId'));

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => Turma.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch turmas.');
    }
  }
}