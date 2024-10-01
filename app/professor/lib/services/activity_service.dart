import 'dart:convert';

import 'package:sistema_escolar/constants.dart';
import 'package:sistema_escolar/model/activity.dart';
import 'package:http/http.dart' as http;

class ActivityService {
  static Future<List<Activity>> getActivities(String turmaId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/atividades?turmaId=$turmaId'));

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => Activity.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch activities.');
    }
  }

  static Future<void> addActivity({
    required String descricao,
    required String turmaId,
  }) async {
    final Map<String, dynamic> data = {
      'descricao': descricao,
      'turmaId': turmaId,
    };

    final response = await http.post(
      Uri.parse('$apiUrl/atividades'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Could not add activity.');
    }
  }

  static Future<void> updateActivity({
    required String descricao,
    required String id,
  }) async {
    final Map<String, dynamic> data = {
      'descricao': descricao,
    };

    final response = await http.patch(
      Uri.parse('$apiUrl/atividades/$id'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Could not update activity.');
    }
  }

  static Future<void> removeActivity(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/atividades/$id'));

    if (response.statusCode != 200) {
      throw Exception('Could not delete activity.');
    }
  }
}
