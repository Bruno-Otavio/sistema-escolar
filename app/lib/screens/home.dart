import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar/main.dart';
import 'package:sistema_escolar/model/turma.dart';
import 'package:sistema_escolar/model/user.dart';
import 'package:sistema_escolar/provider/user_provider.dart';
import 'package:sistema_escolar/services/turma_service.dart';
import 'package:sistema_escolar/widget/turma_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? professor;

  Future? _futureTurmas;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    professor = Provider.of<UserProvider>(context).user;
    _futureTurmas = TurmaService.getTurmas(professor!.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do Professor'),
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
                  const SizedBox(
                    width: 5,
                  ),
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
                  return TurmaWidget(turma: turma);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
