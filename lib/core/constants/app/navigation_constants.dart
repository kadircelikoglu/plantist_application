import 'package:flutter/material.dart';

@immutable
final class NavigationConstants {
  factory NavigationConstants() {
    return _instance;
  }
  const NavigationConstants._internal();
  static const NavigationConstants _instance = NavigationConstants._internal();

  /// MARK: Yönlendirmeler için kullanılan keyword tanımlamaları
  static const String initial = '/';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String reminder = '/reminder';
}
