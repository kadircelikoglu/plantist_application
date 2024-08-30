import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:plantist_case/core/constants/app/app_constants.dart';

@immutable
final class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: AppConstants().androidApiKey,
    appId: AppConstants().androidAppId,
    messagingSenderId: AppConstants().messagingSenderId,
    projectId: AppConstants().projectId,
    storageBucket: AppConstants().storageBucket,
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: AppConstants().iOSApiKey,
    appId: AppConstants().iOSAppId,
    messagingSenderId: AppConstants().messagingSenderId,
    projectId: AppConstants().projectId,
    storageBucket: AppConstants().storageBucket,
    iosBundleId: AppConstants().iOSBundleId,
  );
}
