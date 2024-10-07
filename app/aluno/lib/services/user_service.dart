import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_escolar_aluno/model/user.dart' as app;

class UserService {
  final CollectionReference professores =
      FirebaseFirestore.instance.collection('professores');

  Future<app.User> getCurrentUserInfo(String uid) async {
    final userData = await professores.doc(uid).get();
    final data = userData.data();
    return app.User.fromJson(data as Map<String, dynamic>);
  }
}
