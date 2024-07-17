// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDIYVO1bf_SRsz1W4gJkxgfV56kfJ1XUkE',
    appId: '1:585692192221:web:02e00966fd9f970fde2a34',
    messagingSenderId: '585692192221',
    projectId: 'chatappfluttertutorial',
    authDomain: 'chatappfluttertutorial.firebaseapp.com',
    storageBucket: 'chatappfluttertutorial.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJKNh3daOlksu-0rYvpCJRv8_no0gRHjo',
    appId: '1:585692192221:android:a9f0e25f6d75d333de2a34',
    messagingSenderId: '585692192221',
    projectId: 'chatappfluttertutorial',
    storageBucket: 'chatappfluttertutorial.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAW2wjY_zi4QPU2Wnd1vOdK-bxI6hZoDU4',
    appId: '1:585692192221:ios:253984deddaa6186de2a34',
    messagingSenderId: '585692192221',
    projectId: 'chatappfluttertutorial',
    storageBucket: 'chatappfluttertutorial.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAW2wjY_zi4QPU2Wnd1vOdK-bxI6hZoDU4',
    appId: '1:585692192221:ios:253984deddaa6186de2a34',
    messagingSenderId: '585692192221',
    projectId: 'chatappfluttertutorial',
    storageBucket: 'chatappfluttertutorial.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDIYVO1bf_SRsz1W4gJkxgfV56kfJ1XUkE',
    appId: '1:585692192221:web:1b63653ed417c7dcde2a34',
    messagingSenderId: '585692192221',
    projectId: 'chatappfluttertutorial',
    authDomain: 'chatappfluttertutorial.firebaseapp.com',
    storageBucket: 'chatappfluttertutorial.appspot.com',
  );
}
