import 'dart:async';
import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/auth/verification/service/verification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  RxInt remainingSeconds = 300.obs;
  RxBool showResendButton = false.obs;

  Timer? _timer;

  final VerificationService _verificationService = VerificationService();

  String otpCode = "";

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    remainingSeconds.value = 300;
    showResendButton.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value == 0) {
        showResendButton.value = true;
        timer.cancel();
      } else {
        remainingSeconds.value--;
      }
    });
  }

  String formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return "$m:${s.toString().padLeft(2, '0')}";
  }

  void resendCode() {
    startTimer();
  }

  Future<bool> verifyOtpRequest(String email) async {
    try {
      final response = await _verificationService.verifyOtp(
        email: email,
        otp: otpCode,
      );

      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print("🔐 Verify OTP Status Code: ${response.statusCode}");
        print("🔐 Verify OTP Response: ${response.body}");
      }

      if (response.statusCode == 201 && data["success"] == true) {
        final token = data["data"]["token"];
        final user = data["data"]["user"];

        final userId = user["id"];
        final role = user["role"] ?? "USER";

        await SharedPreferencesHelper.saveTokenAndRole(token, role, userId);
        if (kDebugMode) {
          print("🔥 STORED TOKEN: $token");
          print("🔥 STORED USER ID: $userId");
        }

        Get.snackbar(
          "Success",
          data["message"] ?? "Verification successful",
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "OTP verification failed",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error. Try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<void> resendCodeRequest(String email) async {
    try {
      final response = await _verificationService.resendOtp(email: email);
      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print("🔄 RESEND OTP Status Code: ${response.statusCode}");
        print("🔄 RESEND OTP Response: ${response.body}");
      }

      if (response.statusCode == 201 && data["success"] == true) {
        Get.snackbar(
          "Success",
          data["message"] ?? "OTP resent successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        startTimer();
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Failed to resend OTP",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error. Try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
