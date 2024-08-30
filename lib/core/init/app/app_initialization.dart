import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plantist_case/core/init/app/app_binding.dart';
import 'package:plantist_case/core/init/app/firebase_options.dart';
import 'package:plantist_case/core/init/notification/local_notifications.dart';

@immutable
final class AppInitialization {
  const AppInitialization._();

  // Uygulama açılırken çalışacak ilk method
  static Future<void> initialization() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await LocalNotifications.initLocation();
    AppBinding().dependencies();
  }
}
