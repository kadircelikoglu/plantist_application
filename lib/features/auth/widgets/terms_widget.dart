import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';

final class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          10.h.ph,
          RichText(
            text: TextSpan(
              text: 'By continuing, you agree to our',
              style: GoogleFonts.nunito(color: ColorConstants().gray400, fontSize: 13.sp),
              children: <TextSpan>[
                TextSpan(
                  text: '  Privacy Policy  ',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: ColorConstants().black,
                    decoration: TextDecoration.underline,
                    fontSize: 13.sp,
                  ),
                ),
                TextSpan(
                  text: 'and',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants().gray400,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          1.h.ph,
          CustomText(
            'Terms of Use',
            decoration: TextDecoration.underline,
            textColor: ColorConstants().black,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}
