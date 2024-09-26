import 'package:flutter/material.dart';
import 'package:sistema_escolar/screens/login.dart';
import 'package:sistema_escolar/theme/light_theme.dart';

void main() {
  runApp(const MainApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
