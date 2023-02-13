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
    apiKey: 'AIzaSyCK_lu2_kHMdzCZwJDipJDY3yGVrqungiQ',
    appId: '1:511637126641:web:3bbb036715668c6c085850',
    messagingSenderId: '511637126641',
    projectId: 'ring-size-calculator',
    authDomain: 'ring-size-calculator.firebaseapp.com',
    storageBucket: 'ring-size-calculator.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHqu74_dcpRRxs3DCD9WONJpvSqPKIsYY',
    appId: '1:511637126641:android:66327e03f240bbc0085850',
    messagingSenderId: '511637126641',
    projectId: 'ring-size-calculator',
    storageBucket: 'ring-size-calculator.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8bdZmgAJawOjlbMlM30zaqzmxApaWrbY',
    appId: '1:511637126641:ios:738f0e4828b157e1085850',
    messagingSenderId: '511637126641',
    projectId: 'ring-size-calculator',
    storageBucket: 'ring-size-calculator.appspot.com',
    iosClientId: '511637126641-pbsu85r5al2u9m843hbqlg6vo25fa31n.apps.googleusercontent.com',
    iosBundleId: 'com.example.ringSizeCalculator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8bdZmgAJawOjlbMlM30zaqzmxApaWrbY',
    appId: '1:511637126641:ios:738f0e4828b157e1085850',
    messagingSenderId: '511637126641',
    projectId: 'ring-size-calculator',
    storageBucket: 'ring-size-calculator.appspot.com',
    iosClientId: '511637126641-pbsu85r5al2u9m843hbqlg6vo25fa31n.apps.googleusercontent.com',
    iosBundleId: 'com.example.ringSizeCalculator',
  );
}