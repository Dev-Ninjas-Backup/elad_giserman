import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final forgetEmailController = TextEditingController();
  final forgetEmailError = ''.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      forgetEmailError.value = 'Email cannot be empty';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      forgetEmailError.value = 'Enter a valid email';
    } else {
      forgetEmailError.value = '';
    }
  }

  @override
  void onClose() {
    forgetEmailController.dispose();
    super.onClose();
  }
}
