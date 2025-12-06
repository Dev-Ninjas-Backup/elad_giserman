import 'dart:convert';
import 'package:elad_giserman/features/profile/update_password/service/update_password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final RxString oldPassword = ''.obs;
  final RxString newPassword = ''.obs;
  final RxString confirmPassword = ''.obs;

  final RxBool oldPasswordVisible = false.obs;
  final RxBool newPasswordVisible = false.obs;
  final RxBool confirmPasswordVisible = false.obs;
  final RxBool isSubmitting = false.obs;

  final UpdatePasswordService _service = UpdatePasswordService();

  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'err_old_password_required'.tr;
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'err_new_password_required'.tr;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'err_confirm_password_required'.tr;
    }
    if (value != newPassword.value) {
      return 'err_password_mismatch'.tr;
    }
    return null;
  }

  void toggleOldPasswordVisibility() {
    oldPasswordVisible.value = !oldPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    newPasswordVisible.value = !newPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  Future<void> updatePassword() async {
    final oldError = validateOldPassword(oldPassword.value);
    final newError = validateNewPassword(newPassword.value);
    final confirmError = validateConfirmPassword(confirmPassword.value);

    if (oldError != null || newError != null || confirmError != null) {
      Get.snackbar('snack_validation_error'.tr, 'snack_fix_errors'.tr);
      return;
    }

    try {
      isSubmitting.value = true;

      final response = await _service.changePassword(
        currentPassword: oldPassword.value,
        newPassword: newPassword.value,
      );

      print('📊 Change Password Response Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        print('✅ Password Changed Successfully');

        Get.snackbar('snack_success'.tr, 'snack_password_updated'.tr);

        oldPassword.value = '';
        newPassword.value = '';
        confirmPassword.value = '';

        Future.delayed(Duration(seconds: 1), () {
          Get.back();
        });
      } else {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['message'] ?? 'Failed to update password';
        print('❌ Change Password Failed: $errorMessage');

        Get.snackbar(
          'snack_error'.tr,
          errorMessage,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Change Password Exception: $e');
      Get.snackbar(
        'snack_error'.tr,
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
