import 'dart:convert';
import 'package:elad_giserman/core/services/google_auth_service.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/auth/sign_up/service/auth_service.dart';
import 'package:elad_giserman/features/auth/verification/screen/verification_screen.dart';
import 'package:elad_giserman/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    Get.snackbar(
      "Please wait",
      "Creating your account...",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
    );

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
        Get.snackbar(
          "Success",
          data["message"] ?? "Registration successful",
          snackPosition: SnackPosition.BOTTOM,
          // ignore: deprecated_member_use
          backgroundColor: Colors.green.withOpacity(0.2),
        );
        Get.to(
          VerificationScreen(
            verificationEmail: emailController.text,
            previousScreen: '/signUpScreen',
          ),
        );
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          // ignore: deprecated_member_use
          backgroundColor: Colors.red.withOpacity(0.2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Network Error",
        "Please check your internet connection.",
        snackPosition: SnackPosition.BOTTOM,
        // ignore: deprecated_member_use
        backgroundColor: Colors.red.withOpacity(0.2),
      );

      if (kDebugMode) {
        print("SignUp Error: $e");
      }
    }
  }

  Future<void> signUpWithGoogle() async {
    if (kDebugMode) {
      print('Initiating Google sign-up');
    }

    Get.snackbar(
      "Please wait",
      "Signing up with Google...",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
    );

    try {
      final response = await GoogleAuthService.performGoogleSignIn();

      if (response == null) {
        Get.snackbar(
          "Error",
          "Google sign-up was cancelled",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return;
      }

      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print("GOOGLE SIGNUP STATUS: ${response.statusCode}");
        print("GOOGLE SIGNUP RESPONSE: ${response.body}");
      }

      if (response.statusCode == 201 && data["success"] == true) {
        final token = data["data"]["token"];
        final user = data["data"]["user"];

        final role = user["role"] ?? "USER";
        final userId = user["id"];

        await SharedPreferencesHelper.saveTokenAndRole(token, role, userId);

        Get.snackbar(
          "Success",
          data["message"] ?? "Signed up with Google successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.2),
        );

        Get.offAllNamed(AppRoute.navBarScreen);
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Google sign-up failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
      }
    } catch (e) {
      String errorMessage = "Google sign-up failed. Try again.";

      if (e.toString().contains('Google Sign-In not properly configured')) {
        errorMessage =
            "Google Sign-In requires additional setup. Please contact support.";
      } else if (e.toString().contains('sign_in_canceled')) {
        errorMessage = "Google sign-up was cancelled.";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
      );

      if (kDebugMode) {
        print("Google Sign-Up Error: $e");
      }
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
