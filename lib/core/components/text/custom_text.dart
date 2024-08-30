import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';

@immutable
final class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.args,
    super.key,
    this.textAlign,
    this.textColor,
    this.fontWeight,
    this.fontSize = 14,
    this.decoration,
  }) : super();
  final String text;
  final List<String>? args;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        color: textColor ?? ColorConstants().black,
        fontWeight: fontWeight,
        fontSize: fontSize?.sp,
        decoration: decoration,
      ),
      textAlign: textAlign,
    );
  }
}
