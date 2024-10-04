import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistema_escolar_aluno/main.dart';

class AuthService {
  Future<void> signUp({
    required String nome,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCredential.user!.updateDisplayName(nome);

      navigatorKey.currentState?.pushReplacementNamed('/login');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-passowrd') {
        message = 'Senha fraca.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email já esta sendo selecionado.';
      }

      snackbarKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      navigatorKey.currentState?.pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Usuário ou senha incorretos.';
      } else {
        message = 'Algo deu de errado.';
      }

      snackbarKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
