import 'package:flutter/material.dart';

@immutable
final class ColorConstants {
  factory ColorConstants() {
    return _instance;
  }
  const ColorConstants._privateConstructor();

  static const ColorConstants _instance = ColorConstants._privateConstructor();
  static Color get mainColor => const Color(0xff5316D8);

  /// White - Black
  Color get white => const Color(0xffFFFFFF);
  Color get black => const Color(0xff000000);

  /// MARK: Blue
  Color get blue400 => const Color(0xff0094FF);

  /// MARK: Red
  Color get red400 => const Color(0xffF44837);

  /// MARK: Black
  Color get black400 => const Color(0xff2C2C2C);
  Color get black300 => const Color(0xff5A5A5A);
  Color get black200 => const Color(0xff999999);
  Color get black100 => const Color(0xff1A1924);
  Color get black50 => const Color(0xffF3F3F3);

  /// MARK: Gray
  Color get gray400 => const Color(0xff8D8C92);
  Color get gray200 => const Color(0xffB7BABF);
  Color get gray100 => const Color(0xffD0D5DD);
  Color get gray50 => const Color(0xffF5F5F5);
}
