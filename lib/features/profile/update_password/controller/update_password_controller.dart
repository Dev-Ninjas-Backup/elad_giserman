import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final RxString oldPassword = ''.obs;
  final RxString newPassword = ''.obs;
  final RxString confirmPassword = ''.obs;

  final RxBool oldPasswordVisible = false.obs;
  final RxBool newPasswordVisible = false.obs;
  final RxBool confirmPasswordVisible = false.obs;

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
    if (value.length < 6) {
      return 'err_password_length'.tr;
    }
    if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
      return 'err_password_uppercase'.tr;
    }
    if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
      return 'err_password_lowercase'.tr;
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
      return 'err_password_number'.tr;
    }
    if (!RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return 'err_password_special'.tr;
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

  void updatePassword() {
    final oldError = validateOldPassword(oldPassword.value);
    final newError = validateNewPassword(newPassword.value);
    final confirmError = validateConfirmPassword(confirmPassword.value);

    if (oldError != null || newError != null || confirmError != null) {
      Get.snackbar('snack_validation_error'.tr, 'snack_fix_errors'.tr);
      return;
    }
    Get.snackbar('snack_success'.tr, 'snack_password_updated'.tr);
    oldPassword.value = '';
    newPassword.value = '';
    confirmPassword.value = '';
  }
}
