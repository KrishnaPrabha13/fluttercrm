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
    apiKey: 'AIzaSyDFLQ3jfiSSWTHEu5NMYp28v3CENZ6hcIE',
    appId: '1:901215406526:web:9986392869ce0f8ae091ef',
    messagingSenderId: '901215406526',
    projectId: 'crmproject-15301',
    authDomain: 'crmproject-15301.firebaseapp.com',
    storageBucket: 'crmproject-15301.appspot.com',
    measurementId: 'G-7H3DWY7JN0',
    databaseURL: "https://crmproject-15301-default-rtdb.firebaseio.com/",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbsgpipKLN99qJIjjQiWPc9w9pA0dft6A',
    appId: '1:901215406526:android:31b26dda31993ad0e091ef',
    messagingSenderId: '901215406526',
    projectId: 'crmproject-15301',
    storageBucket: 'crmproject-15301.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDK4peT2DpfajdsRlSXQtsx-ucpxkP9Jaw',
    appId: '1:901215406526:ios:e7316c6fe209171ce091ef',
    messagingSenderId: '901215406526',
    projectId: 'crmproject-15301',
    storageBucket: 'crmproject-15301.appspot.com',
    iosClientId:
        '901215406526-khdrshu1fljulo4440u57ve2eqvhjhg6.apps.googleusercontent.com',
    iosBundleId: 'com.srmt.crmDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDK4peT2DpfajdsRlSXQtsx-ucpxkP9Jaw',
    appId: '1:901215406526:ios:97e4345612a12ff8e091ef',
    messagingSenderId: '901215406526',
    projectId: 'crmproject-15301',
    storageBucket: 'crmproject-15301.appspot.com',
    iosClientId:
        '901215406526-7gqjgadndj2alsdp0jll1rb9ajk8ekiv.apps.googleusercontent.com',
    iosBundleId: 'com.srmt.crmDashboard.RunnerTests',
  );
}
