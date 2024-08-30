import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';
import 'package:plantist_case/core/helpers/typedefs/typedefs.dart';

@immutable
final class ReminderTopWidget extends StatelessWidget {
  const ReminderTopWidget({
    required this.title,
    required this.onPressed,
    this.buttonText,
    this.isCreateReminder = true,
    super.key,
  });
  final String title;
  final OnFunction onPressed;
  final bool isCreateReminder;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCreateReminder ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => Get.back<void>(),
          child: CustomText(
            'Cancel',
            textColor: ColorConstants().blue400,
            fontSize: 18,
          ),
        ),
        if (!isCreateReminder) 60.w.pw,
        CustomText(
          title,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
        if (isCreateReminder)
          TextButton(
            onPressed: onPressed,
            child: CustomText(
              buttonText ?? 'Add',
              textColor: ColorConstants().gray200,
              fontSize: 18,
            ),
          ),
      ],
    );
  }
}
