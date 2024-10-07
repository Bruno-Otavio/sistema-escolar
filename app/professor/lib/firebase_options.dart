// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:sistema_escolar/constants.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: androidApiKey,
    appId: '1:311666309461:android:3aa3075ba9b5bebf5897dc',
    messagingSenderId: '311666309461',
    projectId: 'sistema-escolar-28dfc',
    databaseURL: 'https://sistema-escolar-28dfc-default-rtdb.firebaseio.com',
    storageBucket: 'sistema-escolar-28dfc.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: iosApiKey,
    appId: '1:311666309461:ios:72ff71526e4d5bef5897dc',
    messagingSenderId: '311666309461',
    projectId: 'sistema-escolar-28dfc',
    databaseURL: 'https://sistema-escolar-28dfc-default-rtdb.firebaseio.com',
    storageBucket: 'sistema-escolar-28dfc.appspot.com',
    iosBundleId: 'com.example.sistemaEscolar',
  );
}