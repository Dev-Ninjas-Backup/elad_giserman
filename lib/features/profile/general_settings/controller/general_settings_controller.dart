import 'package:get/get.dart';

class GeneralSettingsController extends GetxController {
  final language = 'English'.obs;
  final notificationsEnabled = true.obs;

  void setLanguage(String value) {
    language.value = value;
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }
}
