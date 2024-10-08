import 'package:flutter/material.dart';
import 'package:sistema_escolar/services/auth_service.dart';
import 'package:sistema_escolar/widget/button.dart';
import 'package:sistema_escolar/widget/text_input.dart';
import 'package:sistema_escolar/widget/text_input_toggle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final AuthService authService = AuthService();
      await authService.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Bem Vindo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email.';
                      }
                      return null;
                    },
                    controller: _emailController,
                    hintText: 'Email',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  TextInputToggle(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha.';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    hintText: 'Senha',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  Button(
                    onPressed: _login,
                    text: 'Entrar',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
