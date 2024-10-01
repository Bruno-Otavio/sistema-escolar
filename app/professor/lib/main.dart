import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar/provider/user_provider.dart';
import 'package:sistema_escolar/screens/home.dart';
import 'package:sistema_escolar/screens/login.dart';
import 'package:sistema_escolar/theme/light_theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MainApp(),
  ));
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
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
