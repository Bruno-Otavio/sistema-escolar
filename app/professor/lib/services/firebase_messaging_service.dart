import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    initNotifications();
  }

  Future initPushNotifications() async {
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificação: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('Notificação clicada');
  }
}