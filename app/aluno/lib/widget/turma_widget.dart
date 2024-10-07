import 'package:flutter/material.dart';
import 'package:sistema_escolar_aluno/main.dart';
import 'package:sistema_escolar_aluno/model/turma.dart';
import 'package:sistema_escolar_aluno/screens/activities.dart';
import 'package:sistema_escolar_aluno/widget/small_button.dart';

class TurmaWidget extends StatelessWidget {
  const TurmaWidget({
    super.key,
    required this.turma,
  });

  final Turma turma;

  void _openActivities() {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => ActivitiesScreen(turma: turma)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Container(
        height: 200,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turma.nome,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    turma.escola,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border(
                      top: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 10),
                  SmallButton(
                    onPressed: _openActivities,
                    text: 'Visualizar',
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
