import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/core/services/google_auth_service.dart';
import 'package:elad_giserman/features/auth/sign_in/service/sign_in_service.dart';
import 'package:elad_giserman/features/home/home/controller/custom_app_details_controller.dart';
import 'package:elad_giserman/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final showPassword = false.obs;
  final isLoading = false.obs;

  final SignInService _service = SignInService();
  final CustomAppDetailsController _appDetailsController = Get.put(
    CustomAppDetailsController(),
  );

  @override
  void onInit() {
    super.onInit();
    _appDetailsController.fetchAppDetails();
  }

  String get logoUrl => _appDetailsController.logoUrl;

  // ---------------- VALIDATION ----------------
  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'err_email_empty'.tr;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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

  Future<void> signIn() async {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await _service.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print("LOGIN STATUS: ${response.statusCode}");
        print("LOGIN RESPONSE: ${response.body}");
      }

      if (response.statusCode == 201 && data["success"] == true) {
        final token = data["data"]["token"];
        final user = data["data"]["user"];

        final role = user["role"] ?? "USER";
        final userId = user["id"];

        await SharedPreferencesHelper.saveTokenAndRole(token, role, userId);

        Get.snackbar(
          "Success",
          data["message"] ?? "Logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed(AppRoute.navBarScreen);
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Login failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error. Try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    if (kDebugMode) {
      print('Initiating Google sign-in');
    }

    isLoading.value = true;

    try {
      final response = await GoogleAuthService.performGoogleSignIn();

      if (response == null) {
        Get.snackbar(
          "Error",
          "Google sign-in was cancelled",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print("GOOGLE LOGIN STATUS: ${response.statusCode}");
        print("GOOGLE LOGIN RESPONSE: ${response.body}");
      }

      if (response.statusCode == 201 && data["success"] == true) {
        final token = data["data"]["token"];
        final user = data["data"]["user"];

        final role = user["role"] ?? "USER";
        final userId = user["id"];

        await SharedPreferencesHelper.saveTokenAndRole(token, role, userId);

        Get.snackbar(
          "Success",
          data["message"] ?? "Signed in with Google successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed(AppRoute.navBarScreen);
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Google sign-in failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      String errorMessage = "Google sign-in failed. Try again.";

      if (e.toString().contains('Google Sign-In not properly configured')) {
        errorMessage =
            "Google Sign-In requires additional setup. Please contact support.";
      } else if (e.toString().contains('sign_in_canceled')) {
        errorMessage = "Google sign-in was cancelled.";
      }

      Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);

      if (kDebugMode) {
        print("Google Sign-In Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
