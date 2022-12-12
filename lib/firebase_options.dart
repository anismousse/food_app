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
    apiKey: 'AIzaSyAbdanQqKeIYtdlAeYVdTU_b6rVFxLK_1s',
    appId: '1:744670055986:web:a0c534ab8584f9118f362b',
    messagingSenderId: '744670055986',
    projectId: 'akin-reminder-app',
    authDomain: 'akin-reminder-app.firebaseapp.com',
    storageBucket: 'akin-reminder-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxDXqKMWYhAk1ypGRVCmGEBjX-vKtmaEs',
    appId: '1:744670055986:android:8d74ec0f4d4e126b8f362b',
    messagingSenderId: '744670055986',
    projectId: 'akin-reminder-app',
    storageBucket: 'akin-reminder-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzhGZaFF86Jk3ab78hT1TWrPsMLEY1_lE',
    appId: '1:744670055986:ios:46a50dc3ecc781e68f362b',
    messagingSenderId: '744670055986',
    projectId: 'akin-reminder-app',
    storageBucket: 'akin-reminder-app.appspot.com',
    iosClientId: '744670055986-8kjsehebsuhl0ho34c7h1puufisns5gk.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzhGZaFF86Jk3ab78hT1TWrPsMLEY1_lE',
    appId: '1:744670055986:ios:46a50dc3ecc781e68f362b',
    messagingSenderId: '744670055986',
    projectId: 'akin-reminder-app',
    storageBucket: 'akin-reminder-app.appspot.com',
    iosClientId: '744670055986-8kjsehebsuhl0ho34c7h1puufisns5gk.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodapp',
  );
}