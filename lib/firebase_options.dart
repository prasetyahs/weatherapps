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
    apiKey: 'AIzaSyBeZwYcxPhml3PvuYoH22PNYHIt_4YXsZQ',
    appId: '1:178777477990:web:5cfb7e20d97dea4ad62ea7',
    messagingSenderId: '178777477990',
    projectId: 'weatherapps-6cc4d',
    authDomain: 'weatherapps-6cc4d.firebaseapp.com',
    storageBucket: 'weatherapps-6cc4d.appspot.com',
    measurementId: 'G-CBGLQM9ETG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCI-cClwc-v6I-Sco1Z_mEkhuNfCMa_s1Q',
    appId: '1:178777477990:android:67c11180e45d723dd62ea7',
    messagingSenderId: '178777477990',
    projectId: 'weatherapps-6cc4d',
    storageBucket: 'weatherapps-6cc4d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqT72_12mO9XkKkzQk6lK8WM10qJM4I6M',
    appId: '1:178777477990:ios:09f27f5979f6786ed62ea7',
    messagingSenderId: '178777477990',
    projectId: 'weatherapps-6cc4d',
    storageBucket: 'weatherapps-6cc4d.appspot.com',
    iosBundleId: 'com.phs.weatherApps',
  );
}