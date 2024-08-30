// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/button/app_primary_button.dart';
import 'package:plantist_case/core/components/scaffold/custom_scaffold.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/components/textField/custom_text_field.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';
import 'package:plantist_case/features/auth/login/controller/login_controller.dart';
import 'package:plantist_case/features/auth/widgets/header_widget.dart';
import 'package:plantist_case/features/auth/widgets/terms_widget.dart';

final class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.horizontalLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(
                header: 'in',
              ),
              Obx(
                () {
                  return Padding(
                    padding: context.padding.horizontalLow,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'E-mail',
                          textEditingController: controller.emailController,
                          suffixIcon: controller.isButtonActive.value ? SvgPicture.asset(IconEnums.done.svgPath) : const SizedBox.shrink(),
                        ),
                        45.h.ph,
                        CustomTextField(
                          hintText: 'Password',
                          textEditingController: controller.passwordController,
                          obscureText: controller.isShow.isFalse ? true : false,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.isShow.toggle();
                            },
                            child: controller.isShow.isTrue ? SvgPicture.asset(IconEnums.openEye.svgPath) : SvgPicture.asset(IconEnums.closeEye.svgPath),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: context.padding.onlyTopLow * 1.5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: CustomText(
                      'Forgot Password?',
                      fontWeight: FontWeight.w700,
                      textColor: ColorConstants().blue400,
                    ),
                  ),
                ),
              ),
              Obx(
                () {
                  return Padding(
                    padding: context.padding.onlyTopMedium,
                    child: Center(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator.adaptive()
                          : AppPrimaryButton(
                              onTap: controller.isButtonActive.value
                                  ? () {
                                      controller.signIn(
                                        context: context,
                                        email: controller.emailController.text,
                                        password: controller.passwordController.text,
                                      );
                                    }
                                  : () {},
                              text: 'Sign In',
                              buttonColor: controller.isButtonActive.value ? ColorConstants().black : ColorConstants().gray200,
                              textColor: ColorConstants().white,
                            ),
                    ),
                  );
                },
              ),
              const TermsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
