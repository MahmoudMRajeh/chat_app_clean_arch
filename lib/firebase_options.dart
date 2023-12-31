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
    apiKey: 'AIzaSyCFrgUNhNR754L4cLawkubrKsB2DARbuwY',
    appId: '1:424676530023:web:d030d9e721eaeaf5a681c2',
    messagingSenderId: '424676530023',
    projectId: 'chat-app-with-clean-arch',
    authDomain: 'chat-app-with-clean-arch.firebaseapp.com',
    storageBucket: 'chat-app-with-clean-arch.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFuahkgx4KbOVuG2fWlp2a6Ca0pEbn6LU',
    appId: '1:424676530023:android:a9926bafdb3fa03ba681c2',
    messagingSenderId: '424676530023',
    projectId: 'chat-app-with-clean-arch',
    storageBucket: 'chat-app-with-clean-arch.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVwJNqNrQC_HKDLzr1M8pAwj-CUYSLBgc',
    appId: '1:424676530023:ios:c843fc4a11d4c3dfa681c2',
    messagingSenderId: '424676530023',
    projectId: 'chat-app-with-clean-arch',
    storageBucket: 'chat-app-with-clean-arch.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVwJNqNrQC_HKDLzr1M8pAwj-CUYSLBgc',
    appId: '1:424676530023:ios:c843fc4a11d4c3dfa681c2',
    messagingSenderId: '424676530023',
    projectId: 'chat-app-with-clean-arch',
    storageBucket: 'chat-app-with-clean-arch.appspot.com',
    iosBundleId: 'com.example.chat',
  );
}
