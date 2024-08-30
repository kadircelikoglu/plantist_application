import 'package:get/get.dart';
import 'package:plantist_case/core/components/popups/controller/reminder_controller.dart';
import 'package:plantist_case/features/auth/login/controller/login_controller.dart';
import 'package:plantist_case/features/auth/register/controller/register_controller.dart';
import 'package:plantist_case/features/home/controller/home_controller.dart';

final class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<LoginController>(
        LoginController.new,
      )
      ..lazyPut<RegisterController>(
        RegisterController.new,
      )
      ..lazyPut<ReminderController>(
        ReminderController.new,
      )
      ..lazyPut<HomeController>(
        HomeController.new,
      );
  }
}
