import 'package:flutter/material.dart';
import 'package:sistema_escolar/model/turma.dart';
import 'package:sistema_escolar/widget/small_button.dart';

class TurmaWidget extends StatelessWidget {
  const TurmaWidget({
    super.key,
    required this.turma,
  });

  final Turma turma;

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
                shadows: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ),
                ],
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
                    turma.id,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallButton(
                    onPressed: () {},
                    text: 'Excluir',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  SmallButton(
                    onPressed: () {},
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
