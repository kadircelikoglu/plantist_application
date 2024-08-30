import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/helpers/typedefs/typedefs.dart';

final class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText,
    this.onChanged,
    this.focusedEnabledColor,
    this.obscureText = false,
    this.textEditingController,
    this.suffixIcon,
    this.enabledBorderColor,
    this.maxLines = 1,
    super.key,
  });
  final OnChanged? onChanged;
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final Color? enabledBorderColor;
  final Color? focusedEnabledColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorConstants().black,
      controller: textEditingController,
      onChanged: onChanged,
      maxLines: maxLines,
      obscureText: obscureText,
      
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
          color: ColorConstants().gray200,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.all(12.h),
          child: suffixIcon,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: focusedEnabledColor ?? ColorConstants().gray200),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants().gray200),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor ?? ColorConstants().gray200),
        ),
      ),
      style: GoogleFonts.nunito(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
