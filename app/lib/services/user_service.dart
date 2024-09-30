import 'dart:convert';

import 'package:sistema_escolar/constants.dart';
import 'package:sistema_escolar/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await http.get(
      Uri.parse('$apiUrl/professores?email=$email&password=$password'),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return User.fromJson(body[0] as Map<String, dynamic>);
    } else {
      throw Exception('Could not fetch teacher.');
    }
  }
}
