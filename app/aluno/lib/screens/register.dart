import 'package:flutter/material.dart';
import 'package:sistema_escolar_aluno/widget/button.dart';
import 'package:sistema_escolar_aluno/widget/text_input.dart';
import 'package:sistema_escolar_aluno/widget/text_input_toggle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {}

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
                  'Cadastre-se',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome.';
                      }
                      return null;
                    },
                    controller: _nameController,
                    hintText: 'Email',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
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
                    onPressed: _register,
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
