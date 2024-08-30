import 'package:flutter/material.dart';

@immutable
final class AppConstants {
  String get appName => 'Plantist App';
  String get projectId => 'plantist-case';
  String get storageBucket => 'plantist-case.appspot.com';
  String get iOSBundleId => 'com.example.plantistCase';
  String get messagingSenderId => '1025287219379';

  //* Android
  String get androidAppId => '1:1025287219379:android:2c14ab78edf2e2bc8a28c6';
  String get androidApiKey => 'AIzaSyCwmBWOoQ5o1ItcDFrHkCdsInQXikUxg3c';

  //* iOS
  String get iOSAppId => '1:1025287219379:ios:184813e4ca14f1558a28c6';
  String get iOSApiKey => 'AIzaSyAVwbusWIt03UyqUn54aCLunTwJ9Qqb2hA';
}
