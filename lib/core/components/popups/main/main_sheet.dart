import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';

@immutable
final class MainBottomSheet {
  Future<dynamic> mainSheet(
    BuildContext context, {
    required Widget child,
    String? icon,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: context.sized.height / 1.35,
          decoration: BoxDecoration(
            color: ColorConstants().white,
            borderRadius: BorderRadius.only(
              topLeft: context.border.lowRadius,
              topRight: context.border.lowRadius,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
