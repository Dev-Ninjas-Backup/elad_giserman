// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/core/services/translation_service.dart';
import 'package:elad_giserman/features/profile/main/service/profile_service.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/details/controller/details_controller.dart';

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

    // Get the language code for translation
    String languageCode = value == 'hebrew' ? 'he' : 'en';

    // Update locale
    if (value == 'hebrew') {
      Get.updateLocale(Locale('he', 'IL'));
    } else {
      Get.updateLocale(Locale('en', 'US'));
    }

    // Update translation service language
    try {
      final translationService = Get.find<TranslationService>();
      translationService.updateLanguage(languageCode);

      // Trigger translation of all data in home screen
      if (Get.isRegistered<HomeController>()) {
        final homeController = Get.find<HomeController>();
        await homeController.translateAllData(languageCode);
      }

      // Trigger translation of details screen if open
      if (Get.isRegistered<DetailsController>()) {
        final detailsController = Get.find<DetailsController>();
        await detailsController.translateDetail(languageCode);
      }
    } catch (e) {
      print('⚠️ Translation service not available: $e');
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
