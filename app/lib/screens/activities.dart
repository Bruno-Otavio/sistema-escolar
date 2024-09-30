import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar/main.dart';
import 'package:sistema_escolar/model/activity.dart';
import 'package:sistema_escolar/model/turma.dart';
import 'package:sistema_escolar/model/user.dart';
import 'package:sistema_escolar/provider/user_provider.dart';
import 'package:sistema_escolar/services/activity_service.dart';
import 'package:sistema_escolar/widget/activity_widget.dart';

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
                        return ActitvityWidget(activity: activity);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
