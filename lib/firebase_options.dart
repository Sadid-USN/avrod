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
    apiKey: 'AIzaSyC_5RsGFxclhkVi_1c7OgjQ8p7l7-VP-jg',
    appId: '1:150846456276:web:7be50f2ab7d2e724cd9641',
    messagingSenderId: '150846456276',
    projectId: 'avrod-a2224',
    authDomain: 'avrod-a2224.firebaseapp.com',
    databaseURL: 'https://avrod-a2224-default-rtdb.firebaseio.com',
    storageBucket: 'avrod-a2224.appspot.com',
    measurementId: 'G-8LJ0BX6ZQ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSMaHBd2G424PBTKIDHl4_ELpb7Oy47Vo',
    appId: '1:150846456276:android:8455d9b876b09cbacd9641',
    messagingSenderId: '150846456276',
    projectId: 'avrod-a2224',
    databaseURL: 'https://avrod-a2224-default-rtdb.firebaseio.com',
    storageBucket: 'avrod-a2224.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADKmtLPkiFoSQCvp8CXocbrRD8HbI_jD4',
    appId: '1:150846456276:ios:9196fcf04ec32455cd9641',
    messagingSenderId: '150846456276',
    projectId: 'avrod-a2224',
    databaseURL: 'https://avrod-a2224-default-rtdb.firebaseio.com',
    storageBucket: 'avrod-a2224.appspot.com',
    androidClientId: '150846456276-hs56pqgs6nmv3qg84k0m41gtapvfk8ib.apps.googleusercontent.com',
    iosClientId: '150846456276-huhu6ljvqtndmft1v7kei4l57cblj3jd.apps.googleusercontent.com',
    iosBundleId: 'com.darulasar.avrod',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADKmtLPkiFoSQCvp8CXocbrRD8HbI_jD4',
    appId: '1:150846456276:ios:9196fcf04ec32455cd9641',
    messagingSenderId: '150846456276',
    projectId: 'avrod-a2224',
    databaseURL: 'https://avrod-a2224-default-rtdb.firebaseio.com',
    storageBucket: 'avrod-a2224.appspot.com',
    androidClientId: '150846456276-hs56pqgs6nmv3qg84k0m41gtapvfk8ib.apps.googleusercontent.com',
    iosClientId: '150846456276-huhu6ljvqtndmft1v7kei4l57cblj3jd.apps.googleusercontent.com',
    iosBundleId: 'com.darulasar.avrod',
  );
}
