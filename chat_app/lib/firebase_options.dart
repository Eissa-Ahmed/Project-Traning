// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyByaqDESCpyQBkAaGUzpEdEpZ2eWvGbAZA',
    appId: '1:947444863365:web:517bebb9f9804a79b4b4ec',
    messagingSenderId: '947444863365',
    projectId: 'chat-app-56545',
    authDomain: 'chat-app-56545.firebaseapp.com',
    storageBucket: 'chat-app-56545.appspot.com',
    measurementId: 'G-L3VY55Z4TW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWknEr-8gqOgLTeXfmJu5jvqJ4gXE68JA',
    appId: '1:947444863365:android:c373189d05943712b4b4ec',
    messagingSenderId: '947444863365',
    projectId: 'chat-app-56545',
    storageBucket: 'chat-app-56545.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGSe3JtwKylDHB4UL8AiRQej1dbQryC28',
    appId: '1:947444863365:ios:68b0185bb1291a8cb4b4ec',
    messagingSenderId: '947444863365',
    projectId: 'chat-app-56545',
    storageBucket: 'chat-app-56545.appspot.com',
    iosClientId: '947444863365-q8njs0b89sj6maalg2a1o14ncg8b0ic7.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGSe3JtwKylDHB4UL8AiRQej1dbQryC28',
    appId: '1:947444863365:ios:68b0185bb1291a8cb4b4ec',
    messagingSenderId: '947444863365',
    projectId: 'chat-app-56545',
    storageBucket: 'chat-app-56545.appspot.com',
    iosClientId: '947444863365-q8njs0b89sj6maalg2a1o14ncg8b0ic7.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}