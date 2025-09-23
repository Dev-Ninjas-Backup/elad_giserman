import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final showPassword = false.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'err_email_empty'.tr;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) &&
        value.length < 3) {
      emailError.value = 'err_email_invalid'.tr;
    } else {
      emailError.value = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'err_password_empty'.tr;
    } else if (value.length < 6) {
      passwordError.value = 'err_password_short'.tr;
    } else {
      passwordError.value = '';
    }
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void signIn() {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      if (kDebugMode) {
        print(
          'Sign in with: ${emailController.text}, ${passwordController.text}',
        );
        Get.offAllNamed('/navBarScreen');
      }
    }
  }

  void signInWithGoogle() {
    if (kDebugMode) {
      print('Initiating Google sign-up');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
