import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

String constructFCMPayload(String? token) {
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': 'text',
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification was created via FCM!',
    },
  });
}

class FirebaseMessagingService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    initNotifications();
    _firebaseMessaging.subscribeToTopic('topic');
  }

  Future initPushNotifications() async {
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificação: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/sistema-escolar-28dfc/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_firebaseMessaging.getToken().toString()),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('Notificação clicada');
  }
}