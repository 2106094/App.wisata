
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDcolbDnyScebKVP7YIaDPl_8oUJP6sE6g',
    appId: '1:520832173799:web:ec998cb7fe8290055b8442',
    messagingSenderId: '520832173799',
    projectId: 'aplikasiwisata-34728',
    authDomain: 'aplikasiwisata-34728.firebaseapp.com',
    storageBucket: 'aplikasiwisata-34728.appspot.com',
    measurementId: 'G-SF0WK51MZK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGbLta219r2CdokM07L1DVpIYTazk6hj4',
    appId: '1:520832173799:android:758645feedf3d5e65b8442',
    messagingSenderId: '520832173799',
    projectId: 'aplikasiwisata-34728',
    storageBucket: 'aplikasiwisata-34728.appspot.com',
  );
}
