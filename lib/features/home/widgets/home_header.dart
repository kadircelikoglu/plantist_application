import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/components/textField/custom_text_field.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';
import 'package:plantist_case/features/home/controller/home_controller.dart';

final class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.homeController, super.key});
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: context.padding.horizontalNormal + context.padding.onlyTopLow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Plantist',
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
              Row(
                children: [
                  if (homeController.isSearchVisible.value)
                    SizedBox(
                      width: context.sized.width * 0.3,
                      child: CustomTextField(
                        hintText: 'Search TODOs...',
                        onChanged: homeController.filterTodos,
                      ),
                    ),
                  5.w.pw,
                  InkWell(
                    onTap: homeController.toggleSearchVisibility,
                    child: homeController.isSearchVisible.value
                        ? const Icon(Icons.close)
                        : SvgPicture.asset(
                            IconEnums.search.svgPath,
                            height: 30.h,
                          ),
                  ),
                  5.w.pw,
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: homeController.logout,
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.logout_outlined),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
