import 'dart:convert';

import 'package:sistema_escolar/constants.dart';
import 'package:sistema_escolar/model/activity.dart';
import 'package:http/http.dart' as http;

class ActivityService {
  static Future<List<Activity>> getActivities(String turmaId) async {
    final response = await http.get(Uri.parse('$apiUrl/atividades?turmaId=$turmaId'));
    
    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => Activity.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch activities.');
    }
  }
}