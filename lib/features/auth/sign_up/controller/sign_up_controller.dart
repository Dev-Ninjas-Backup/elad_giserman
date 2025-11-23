import 'dart:convert';
import 'package:elad_giserman/features/auth/sign_up/service/auth_service.dart';
import 'package:elad_giserman/features/auth/verification/screen/verification_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();

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

  Future<void> signUp() async {
    validateUsername(usernameController.text);
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);

    if (usernameError.value.isNotEmpty ||
        emailError.value.isNotEmpty ||
        passwordError.value.isNotEmpty ||
        confirmPasswordError.value.isNotEmpty) {
      return;
    }

    EasyLoading.show(status: "Creating account...");

    await Future.delayed(Duration(milliseconds: 500));

    try {
      final response = await _authService.signUp(
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
      );
      if (kDebugMode) {
        print("SignUp API Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data["success"] == true) {
        EasyLoading.showSuccess(data["message"] ?? "Registration successful");

        Get.to(
          VerificationScreen(
            verificationEmail: emailController.text,
            previousScreen: '/signUpScreen',
          ),
        );
      } else {
        EasyLoading.showError(data["message"] ?? "Registration failed");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong.");

      if (kDebugMode) {
        print("SignUp Error: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signUpWithGoogle() {
    if (kDebugMode) {
      print('Initiating Google sign-up');
    }
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
