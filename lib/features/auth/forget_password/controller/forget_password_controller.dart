import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final forgetEmailController = TextEditingController();
  final resetPasswordController = TextEditingController();
  final confirmresetPasswordController = TextEditingController();

  final forgetEmailError = ''.obs;
  final resetPasswordError = ''.obs;
  final confirmResetPasswordError = ''.obs;

  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      forgetEmailError.value = 'Email cannot be empty';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      forgetEmailError.value = 'Enter a valid email';
    } else {
      forgetEmailError.value = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      resetPasswordError.value = 'Password cannot be empty';
    } else if (value.length < 6) {
      resetPasswordError.value = 'Password must be at least 6 characters';
    } else {
      resetPasswordError.value = '';
    }
    if (confirmresetPasswordController.text.isNotEmpty) {
      validateConfirmPassword(confirmresetPasswordController.text);
    }
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmResetPasswordError.value = 'Confirm password cannot be empty';
    } else if (value != resetPasswordController.text) {
      confirmResetPasswordError.value = 'Passwords do not match';
    } else {
      confirmResetPasswordError.value = '';
    }
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void signUp() {
    validateEmail(forgetEmailController.text);
    validatePassword(resetPasswordController.text);
    validateConfirmPassword(confirmresetPasswordController.text);

    if (forgetEmailError.value.isEmpty &&
        resetPasswordError.value.isEmpty &&
        confirmResetPasswordError.value.isEmpty) {}
  }

  @override
  void onClose() {
    forgetEmailController.dispose();
    super.onClose();
  }
}
