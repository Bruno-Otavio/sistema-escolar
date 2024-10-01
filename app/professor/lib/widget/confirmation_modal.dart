import 'package:flutter/material.dart';
import 'package:sistema_escolar/main.dart';
import 'package:sistema_escolar/widget/small_button.dart';

class ConfirmationModal extends StatelessWidget {
  const ConfirmationModal({
    super.key,
    required this.action,
  });

  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          'Confirmação',
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
        child: Text(
          'Você deseja apagar o item?',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      actions: [
        SmallButton(
          onPressed: navigatorKey.currentState?.pop,
          text: 'Cancelar',
          color: Theme.of(context).colorScheme.primary,
        ),
        SmallButton(
          onPressed: action,
          text: 'Excluir',
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
