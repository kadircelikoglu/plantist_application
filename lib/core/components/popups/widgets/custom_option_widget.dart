import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/helpers/typedefs/typedefs.dart';

@immutable
final class CustomOptionWidget extends StatelessWidget {
  const CustomOptionWidget({required this.onTap, super.key, this.child, this.padding});
  final Widget? child;
  final OnFunction onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? context.padding.onlyTopHigh,
        child: Container(
          height: 75.h,
          decoration: BoxDecoration(
            borderRadius: context.border.lowBorderRadius,
            color: ColorConstants().gray50,
            border: Border.all(color: ColorConstants().gray100),
          ),
          child: child,
        ),
      ),
    );
  }
}
