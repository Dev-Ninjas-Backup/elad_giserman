import 'dart:async';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  RxInt remainingSeconds = 300.obs;
  RxBool showResendButton = false.obs;

  Timer? _timer;

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

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
