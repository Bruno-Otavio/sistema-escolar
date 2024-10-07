import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistema_escolar/main.dart';
import 'package:sistema_escolar/model/activity.dart';
import 'package:sistema_escolar/model/turma.dart';
import 'package:sistema_escolar/services/activity_service.dart';
import 'package:sistema_escolar/widget/action_button.dart';
import 'package:sistema_escolar/widget/activity_widget.dart';
import 'package:sistema_escolar/widget/small_button.dart';
import 'package:sistema_escolar/widget/text_input.dart';

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
  final User _currentUser = FirebaseAuth.instance.currentUser!;

  final ActivityService _activityService = ActivityService();

  final TextEditingController _newActivityController = TextEditingController();

  void _addActivity() {
    showDialog(
      context: context,
      builder: (context) {
        return AddActitivtyModal(
          controller: _newActivityController,
          action: () {
            _activityService.addActivity(
              descricao: _newActivityController.text,
              turmaId: widget.turma.id,
            );

            _newActivityController.text = '';

            navigatorKey.currentState?.pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentUser.displayName!),
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
              child: StreamBuilder(
                stream: _activityService.getActivities(widget.turma.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List activitiesList = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: activitiesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = activitiesList[index];
                        String docId = document.id;

                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        data.addAll({'id': docId});
                        Activity activity = Activity.fromJson(data);

                        return ActitvityWidget(activity: activity);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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
