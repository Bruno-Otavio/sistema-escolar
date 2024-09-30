import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar/main.dart';
import 'package:sistema_escolar/model/turma.dart';
import 'package:sistema_escolar/model/user.dart';
import 'package:sistema_escolar/provider/user_provider.dart';
import 'package:sistema_escolar/services/turma_service.dart';
import 'package:sistema_escolar/widget/action_button.dart';
import 'package:sistema_escolar/widget/small_button.dart';
import 'package:sistema_escolar/widget/text_input.dart';
import 'package:sistema_escolar/widget/turma_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? professor;

  Future? _futureTurmas;

  final TextEditingController _turmaController = TextEditingController();
  final TextEditingController _escolaController = TextEditingController();

  void _refresh() {
    setState(() {
      _futureTurmas = TurmaService.getTurmas(professor!.id);
    });
  }

  void _addTurma() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTurmaModal(
          controller1: _turmaController,
          controller2: _escolaController,
          action: () async {
            try {
              await TurmaService.addTurma(
                nome: _turmaController.text,
                escola: _escolaController.text,
                professorId: professor!.id,
              );

              navigatorKey.currentState?.pop();
              _refresh();
            } catch (e) {
              print(e);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _turmaController.dispose();
    _escolaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    professor = Provider.of<UserProvider>(context).user;
    _futureTurmas = TurmaService.getTurmas(professor!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(professor!.nome),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => navigatorKey.currentState?.pushReplacementNamed(
                '/login',
              ),
              child: Row(
                children: [
                  Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).colorScheme.surface,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: _futureTurmas,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final List data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final Turma turma = data[index];
                  return TurmaWidget(turma: turma, refresh: _refresh);
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: ActionButton(
        onPressed: _addTurma,
        text: '+ Turma',
      ),
    );
  }
}

class AddTurmaModal extends StatelessWidget {
  AddTurmaModal({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.action,
  });

  final TextEditingController controller1;
  final TextEditingController controller2;
  final Function()? action;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          'Adicionar Turma',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da turma.';
                  }
                  return null;
                },
                controller: controller1,
                hintText: 'Nome da Turma',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              TextInput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da escola.';
                  }
                  return null;
                },
                controller: controller2,
                hintText: 'Escola',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
            ],
          ),
        ),
      ),
      actions: [
        SmallButton(
          onPressed: () {
            navigatorKey.currentState?.pop();
            controller1.text = '';
            controller2.text = '';
          },
          text: 'Cancelar',
          color: Theme.of(context).colorScheme.primary,
        ),
        SmallButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              action!();
            }
          },
          text: 'Adicionar',
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
