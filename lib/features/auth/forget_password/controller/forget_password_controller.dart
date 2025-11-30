import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ForgetPasswordController extends GetxController {
  final forgetEmailController = TextEditingController();
  final resetPasswordController = TextEditingController();
  final confirmresetPasswordController = TextEditingController();

  final forgetEmailError = ''.obs;
  final resetPasswordError = ''.obs;
  final confirmResetPasswordError = ''.obs;

  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  final isLoading = false.obs;

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

  Future<bool> sendForgetPassword() async {
    validateEmail(forgetEmailController.text);
    if (forgetEmailError.value.isNotEmpty) {
      return false;
    }

    isLoading.value = true;
    try {
      final url = Uri.parse(Urls.forgetPassword);
      final body = jsonEncode({"email": forgetEmailController.text.trim()});

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (kDebugMode) {
        print("FORGET PASSWORD STATUS: ${response.statusCode}");
        print("FORGET PASSWORD BODY: ${response.body}");
      }

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data["success"] == true) {
          isLoading.value = false;
          Get.snackbar(
            "Success",
            data["message"] ?? "Password reset email sent",
            snackPosition: SnackPosition.BOTTOM,
          );
          return true;
        } else {
          isLoading.value = false;
          Get.snackbar(
            "Error",
            data["message"] ?? "Failed to send reset password email",
            snackPosition: SnackPosition.BOTTOM,
          );
          return false;
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          "Failed to send reset password email",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Network error: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  @override
  void onClose() {
    forgetEmailController.dispose();
    resetPasswordController.dispose();
    confirmresetPasswordController.dispose();
    super.onClose();
  }
}
