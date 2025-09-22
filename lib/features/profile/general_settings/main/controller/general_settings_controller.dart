import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSettingsController extends GetxController {
  final language = 'english'.obs;
  final notificationsEnabled = true.obs;

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
}
