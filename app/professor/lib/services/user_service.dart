import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_escolar/model/user.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<CustomUser> getUser({required String uid}) async {
    final user = await _users.doc(uid).get();
    final data = user.data()!;
    data.addAll({'id': FirebaseAuth.instance.currentUser!.uid});
    return CustomUser.fromJson(data);
  }
}
