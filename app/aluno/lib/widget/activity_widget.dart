import 'package:flutter/material.dart';
import 'package:sistema_escolar_aluno/main.dart';
import 'package:sistema_escolar_aluno/model/activity.dart';
import 'package:sistema_escolar_aluno/services/activity_service.dart';
import 'package:sistema_escolar_aluno/widget/confirmation_modal.dart';
import 'package:sistema_escolar_aluno/widget/small_button.dart';
import 'package:sistema_escolar_aluno/widget/text_input.dart';

class ActitvityWidget extends StatelessWidget {
  ActitvityWidget({
    super.key,
    required this.activity,
    required this.refresh,
  });

  final Activity activity;
  final Function() refresh;

  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.assignment_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.descricao,
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '19 de Janeiro',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EditActitivtyModal(
                        action: () async {
                          try {
                            await ActivityService.updateActivity(
                              descricao: _editingController.text,
                              id: activity.id,
                            );
                            navigatorKey.currentState?.pop();
                            refresh();
                          } catch (e) {
                            print(e);
                          }
                        },
                        controller: _editingController,
                      );
                    },
                  );
                  break;
                case 'delete':
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationModal(action: () async {
                        try {
                          await ActivityService.removeActivity(activity.id);
                          navigatorKey.currentState?.pop();
                          refresh();
                        } catch (e) {
                          print(e);
                        }
                      });
                    },
                  );
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ];
            },
            iconColor: Theme.of(context).colorScheme.primary,
            menuPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            splashRadius: 4,
          ),
        ],
      ),
    );
  }
}

class EditActitivtyModal extends StatelessWidget {
  EditActitivtyModal({
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
          'Editar Atividade',
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
          text: 'Editar',
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
