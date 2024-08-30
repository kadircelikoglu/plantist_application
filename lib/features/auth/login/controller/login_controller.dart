import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_case/features/auth/service/auth_service.dart';
import 'package:plantist_case/features/home/view/home_view.dart';

final class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  //MARK: For password visible or not
  final isShow = false.obs;

  final isLoading = false.obs;

  //MARK: For change color when activated
  final isButtonActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    if ((emailController.text.isNotEmpty && GetUtils.isEmail(emailController.text)) && passwordController.text.isNotEmpty) {
      isButtonActive.value = true;
    } else {
      isButtonActive.value = false;
    }
  }

//MARK: Function that allows us to log in
  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    final user = await _authService.signIn(email, password);
    if (user != null) {
      isLoading.value = false;
      await Get.to(() => const HomeView());
    } else {
      Get.snackbar('Error', 'Logged failed. Please try again.');
    }
    isLoading.value = false;
  }
}
