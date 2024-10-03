import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sistema_escolar_aluno/model/user.dart' as app;
import 'package:http/http.dart' as http;

class UserService {
  final CollectionReference professores =
      FirebaseFirestore.instance.collection('professores');

  Future<app.User> getCurrentUserInfo(String uid) async {
    final userData = await professores.doc(uid).get();
    return app.User.fromJson(userData.data() as Map<String, dynamic>);
  }
}
