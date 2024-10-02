import 'package:flutter/material.dart';
import 'package:sistema_escolar_aluno/model/user.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }
}