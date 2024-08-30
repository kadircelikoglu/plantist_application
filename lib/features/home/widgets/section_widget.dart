import 'package:flutter/widgets.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';

final class SectionWidget extends StatelessWidget {
  const SectionWidget({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title,
      textColor: ColorConstants().gray400,
      fontSize: 18,
    );
  }
}
