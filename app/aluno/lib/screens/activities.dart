import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_aluno/main.dart';
import 'package:sistema_escolar_aluno/model/activity.dart';
import 'package:sistema_escolar_aluno/model/turma.dart';
import 'package:sistema_escolar_aluno/model/user.dart';
import 'package:sistema_escolar_aluno/provider/user_provider.dart';
import 'package:sistema_escolar_aluno/services/activity_service.dart';
import 'package:sistema_escolar_aluno/widget/action_button.dart';
import 'package:sistema_escolar_aluno/widget/activity_widget.dart';
import 'package:sistema_escolar_aluno/widget/small_button.dart';
import 'package:sistema_escolar_aluno/widget/text_input.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({
    super.key,
    required this.turma,
  });

  final Turma turma;

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  User? professor;

  late Future _futureActivities;

  final TextEditingController _newActivityController = TextEditingController();

  void _refresh() {
    setState(() {
      _futureActivities = ActivityService.getActivities(widget.turma.id);
    });
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (context) {
        return AddActitivtyModal(
          controller: _newActivityController,
          action: () async {
            try {
              await ActivityService.addActivity(
                  descricao: _newActivityController.text,
                  turmaId: widget.turma.id);
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
  Widget build(BuildContext context) {
    professor = Provider.of<UserProvider>(context).user;
    _futureActivities = ActivityService.getActivities(widget.turma.id);
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _futureActivities,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final Activity activity = data[index];
                        return ActitvityWidget(
                          activity: activity,
                          refresh: _refresh,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ActionButton(
        onPressed: _addActivity,
        text: '+ Atividade',
      ),
    );
  }
}

class AddActitivtyModal extends StatelessWidget {
  AddActitivtyModal({
    super.key,
    required this.controller,
    required this.action,
  });

  final Function()? action;
  final TextEditingController controller;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          'Adicionar Atividade',
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
                    return 'Por favor, insira a atividade.';
                  }
                  return null;
                },
                controller: controller,
                hintText: 'Atividade',
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
            controller.text = '';
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
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
    );
  }
}
