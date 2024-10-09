import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar/provider/user_provider.dart';
import 'package:sistema_escolar/screens/home.dart';
import 'package:sistema_escolar/screens/login.dart';
import 'package:sistema_escolar/screens/register.dart';
import 'package:sistema_escolar/services/firebase_messaging_service.dart';
import 'package:sistema_escolar/theme/light_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().initNotifications();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MainApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();
final snackbarKey = GlobalKey<ScaffoldMessengerState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const LoginScreen();
            }
            return const HomeScreen();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
