import 'dart:async';
import 'dart:convert';
import 'package:elad_giserman/features/auth/verification/service/verification_service.dart';
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

      if (response.statusCode == 201 && data["success"] == true) {
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

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
