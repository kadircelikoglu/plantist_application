import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';
import 'package:plantist_case/core/helpers/typedefs/typedefs.dart';

final class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    required this.items,
    super.key,
    this.title,
    this.value,
    this.onChanged,
    this.height,
    this.width = 385,
    this.topPadding = 15,
    this.iconColor,
    this.backgroundColor = Colors.black26,
    this.borderRadius,
    this.hint,
    this.selectedItem,
  });
  final String? value;
  final OnDropdownChanged onChanged;
  final List<String> items;
  final String? title;
  final double? height;
  final double width;
  final Color backgroundColor;
  final Color? iconColor;
  final BorderRadius? borderRadius;
  final String? hint;
  final double topPadding;
  final String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 75.h,
          width: context.sized.width,
          decoration: BoxDecoration(
            color: ColorConstants().gray50,
            borderRadius: context.border.lowBorderRadius,
            border: Border.all(color: ColorConstants().gray100),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              enableFeedback: true,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              hint: CustomText(
                title ?? 'Priority',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              alignment: Alignment.centerLeft,
              value: value,
              onChanged: (String? newValue) {
                onChanged!(newValue);
              },
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              icon: Row(
                children: [
                  CustomText(
                    selectedItem ?? 'None',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    textColor: ColorConstants().gray400,
                  ),
                  10.w.pw,
                  SvgPicture.asset(
                    IconEnums.arrowRight.svgPath,
                  ),
                ],
              ),
              items: items
                  .map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: CustomText(
                          val,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  })
                  .toSet()
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
