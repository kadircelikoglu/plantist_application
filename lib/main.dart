import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plantist_case/core/constants/enums/global_enums.dart';
import 'package:plantist_case/core/init/app/app_initialization.dart';
import 'package:plantist_case/features/auth/landing/view/landing_view.dart';

Future<void> main() async {
  await AppInitialization.initialization();
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        SizeEnums.designSize.width,
        SizeEnums.designSize.height,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const GetMaterialApp(
        home: LandingView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
