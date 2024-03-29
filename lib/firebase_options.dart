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
    apiKey: 'AIzaSyAkNzYK_WTWD8XiAijGvrEFPbDTAe637Hc',
    appId: '1:476530509918:web:b52583dd88d054bb090ccf',
    messagingSenderId: '476530509918',
    projectId: 'fir-test-65ec4',
    authDomain: 'fir-test-65ec4.firebaseapp.com',
    storageBucket: 'fir-test-65ec4.appspot.com',
    measurementId: 'G-HKQYCWLSPV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvy6N7QmQaGOwMTSRJPziaYqZs3MybmR0',
    appId: '1:476530509918:android:ef22f9b6b811b61b090ccf',
    messagingSenderId: '476530509918',
    projectId: 'fir-test-65ec4',
    storageBucket: 'fir-test-65ec4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSs0ttMQ2q9jfoQxWMFGp91gGd0Uym-DM',
    appId: '1:476530509918:ios:2c99a6252133bdde090ccf',
    messagingSenderId: '476530509918',
    projectId: 'fir-test-65ec4',
    storageBucket: 'fir-test-65ec4.appspot.com',
    iosBundleId: 'com.example.shoppingApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSs0ttMQ2q9jfoQxWMFGp91gGd0Uym-DM',
    appId: '1:476530509918:ios:305dbebb371aedb8090ccf',
    messagingSenderId: '476530509918',
    projectId: 'fir-test-65ec4',
    storageBucket: 'fir-test-65ec4.appspot.com',
    iosBundleId: 'com.example.shoppingApplication.RunnerTests',
  );
}
