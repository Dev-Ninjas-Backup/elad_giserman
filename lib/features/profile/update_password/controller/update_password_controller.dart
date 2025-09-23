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
      return 'Old password is required';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != newPassword.value) {
      return 'Passwords do not match';
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
      Get.snackbar('Validation Error', 'Please fix the errors in the form');
      return;
    }
    Get.snackbar('Success', 'Password updated successfully');
    oldPassword.value = '';
    newPassword.value = '';
    confirmPassword.value = '';
  }
}
