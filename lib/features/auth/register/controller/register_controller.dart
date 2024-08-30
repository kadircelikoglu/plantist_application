import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_case/features/auth/service/auth_service.dart';
import 'package:plantist_case/features/home/view/home_view.dart';

final class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();
  final isShow = false.obs;
  final isButtonActive = false.obs;
  final isLoading = false.obs;

  AuthService get authService => _authService;

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

  Future<void> createUser({required BuildContext context, required String email, required String password}) async {
    isLoading.value = true;
    try {
      final user = await _authService.registerWithEmailAndPassword(email, password);
      if (user?.uid != null) {
        await Get.to(() => const HomeView());
      } else {
        Get.snackbar(
          'Error',
          'Registration failed. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during registration. Please try again.',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
