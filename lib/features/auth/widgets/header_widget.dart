import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/button/custom_icon_button.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';

final class HeaderWidget extends StatelessWidget {
  const HeaderWidget({required this.header, super.key});
  final String header;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.padding.onlyTopHigh * .75 + context.padding.onlyBottomMedium * .75,
          child: CustomIconButton(
            onPressed: () => Get.back<void>(),
            icon: SvgPicture.asset(IconEnums.arrowLeft.svgPath),
          ),
        ),
        Padding(
          padding: context.padding.onlyLeftLow + context.padding.onlyBottomLow,
          child: CustomText(
            'Sign $header with email',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        Padding(
          padding: context.padding.onlyLeftLow + context.padding.onlyBottomMedium,
          child: CustomText(
            'Enter your email and password',
            textColor: ColorConstants().gray400,
          ),
        ),
      ],
    );
  }
}
