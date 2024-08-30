import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/button/app_primary_button.dart';
import 'package:plantist_case/core/components/scaffold/custom_scaffold.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/features/auth/login/view/login_view.dart';
import 'package:plantist_case/features/auth/register/view/register_view.dart';

final class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: context.padding.onlyTopHigh * 2.5 + context.padding.onlyBottomLow,
              child: SvgPicture.asset(
                IconEnums.landing.svgPath,
                height: context.sized.height / 3,
              ),
            ),
            const CustomText(
              'Welcome back to',
              fontWeight: FontWeight.w200,
              fontSize: 45,
            ),
            const CustomText(
              'Plantist',
              fontWeight: FontWeight.w700,
              fontSize: 45,
            ),
            Padding(
              padding: context.padding.verticalLow,
              child: CustomText(
                'Start your productive life now!',
                textColor: ColorConstants().gray400,
                fontSize: 15,
              ),
            ),
            Padding(
              padding: context.padding.verticalLow,
              child: AppPrimaryButton(
                onTap: () {
                  Get.to<LoginView>(LoginView.new);
                },
                text: 'Sign in with email',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                icon: IconEnums.message,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "Don't you have an account?",
                  textColor: ColorConstants().gray400,
                ),
                TextButton(
                  onPressed: () {
                    Get.to<RegisterView>(RegisterView.new);
                  },
                  child: const CustomText(
                    'Sign up',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
