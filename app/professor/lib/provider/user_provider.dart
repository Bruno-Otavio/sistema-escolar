import 'package:flutter/material.dart';
import 'package:sistema_escolar/model/user.dart';

class UserProvider with ChangeNotifier {
  late CustomUser _user;

  CustomUser get user => _user;

  set user(CustomUser user) {
    _user = user;
    notifyListeners();
  }
}