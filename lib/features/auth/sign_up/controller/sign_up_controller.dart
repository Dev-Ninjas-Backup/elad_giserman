import 'package:elad_giserman/features/auth/verification/screen/verification_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final usernameError = ''.obs;
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;

  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  void validateUsername(String value) {
    if (value.isEmpty) {
      usernameError.value = 'err_username_empty'.tr;
    } else if (value.length < 3) {
      usernameError.value = 'err_username_short'.tr;
    } else {
      usernameError.value = '';
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'err_email_empty_simple'.tr;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      emailError.value = 'err_email_invalid_simple'.tr;
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
    if (confirmPasswordController.text.isNotEmpty) {
      validateConfirmPassword(confirmPasswordController.text);
    }
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = 'err_confirm_password_empty'.tr;
    } else if (value != passwordController.text) {
      confirmPasswordError.value = 'err_password_mismatch'.tr;
    } else {
      confirmPasswordError.value = '';
    }
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void signUp() {
    validateUsername(usernameController.text);
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);

    if (usernameError.value.isEmpty &&
        emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty) {
      if (kDebugMode) {
        print(
          'Sign up with: ${usernameController.text}, ${emailController.text}, ${passwordController.text}',
        );
      }
      Get.to(
        VerificationScreen(
          verificationEmail: emailController.text,
          previousScreen: '/signUpScreen',
        ),
      );
    }
  }

  void signUpWithGoogle() {
    if (kDebugMode) {
      print('Initiating Google sign-up');
    }
    // Get.offAllNamed('/navbarScreen');
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
