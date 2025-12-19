import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/profile/main/service/profile_service.dart';

class GeneralSettingsController extends GetxController {
  final language = 'english'.obs;
  final notificationsEnabled = true.obs;
  final isDeleting = false.obs;

  final ProfileService _profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  void loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLanguage = prefs.getString('selected_language') ?? 'english';
    language.value = savedLanguage;
  }

  void setLanguage(String value) async {
    language.value = value;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', value);

    if (value == 'hebrew') {
      Get.updateLocale(Locale('he', 'IL'));
    } else {
      Get.updateLocale(Locale('en', 'US'));
    }
  }

  String getDisplayLanguage() {
    return language.value == 'hebrew' ? 'hebrew'.tr : 'english'.tr;
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void showDeleteAccountConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('delete_account'.tr),
        content: Text('are_you_sure_delete_account'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
          TextButton(
            onPressed: deleteAccount,
            child: Text('delete'.tr, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> deleteAccount() async {
    Get.back(); // Close dialog

    isDeleting.value = true;

    final token = await SharedPreferencesHelper.getAccessToken();
    if (token == null || token.isEmpty) {
      isDeleting.value = false;
      Get.snackbar(
        'Error',
        'Please login to delete your account',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final success = await _profileService.deleteAccount(token);

      if (success) {
        // Clear all stored data
        await SharedPreferencesHelper.clearAll();

        Get.snackbar(
          'Success',
          'Account deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to sign in screen
        Get.offAllNamed('/signInScreen');
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete account. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while deleting account',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDeleting.value = false;
    }
  }
}
