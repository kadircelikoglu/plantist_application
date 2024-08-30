import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plantist_case/core/components/button/app_primary_button.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';
import 'package:plantist_case/features/home/controller/home_controller.dart';

@immutable
final class AppPopups {
  const AppPopups._();

  static Future<dynamic> mainPopup(
    BuildContext context, {
    required Widget child,
    double height = 317,
    double width = 382,
    Color color = Colors.white,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: Tween<double>(begin: .5, end: 1).animate(animation),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.r),
            ),
            content: SizedBox(
              height: height.h,
              width: width.w,
              child: child,
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> deleteTodoPopup(
    BuildContext context,
    HomeController controller,
    String todoId,
  ) {
    return AppPopups.mainPopup(
      context,
      width: 390.w,
      height: 320,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
        child: Center(
          child: Column(
            children: [
              const CustomText(
                'Notunuzu silmek istediğinize emin misiniz?',
                textAlign: TextAlign.center,
              ),
              50.h.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppPrimaryButton(
                    onTap: () => Get.back<void>(),
                    text: 'Cancel',
                    width: 150,
                    textColor: ColorConstants().white,
                    buttonColor: ColorConstants().black,
                  ),
                  AppPrimaryButton(
                    onTap: () {
                      controller.deleteTodo(context, todoId: todoId);
                    },
                    text: 'Delete',
                    width: 150,
                    textColor: ColorConstants().white,
                    buttonColor: ColorConstants().red400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
