import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';

final class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.onTap,
    required this.text,
    super.key,
    this.icon,
    this.textColor = Colors.black,
    this.height = .07,
    this.width = 400,
    this.buttonColor,
    this.iconSize = 20,
    this.fontSize = 16,
    this.fontWeight,
  });

  final VoidCallback onTap;
  final String text;
  final IconEnums? icon;
  final Color textColor;
  final Color? buttonColor;
  final double height;
  final double width;
  final double iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.sh,
      width: width.w,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: buttonColor ?? ColorConstants().gray50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Row(
                children: [
                  SvgPicture.asset(
                    icon!.svgPath,
                    height: iconSize.h,
                  ),
                  8.w.pw,
                ],
              ),
            CustomText(
              text,
              textColor: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
