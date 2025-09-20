import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  var isLoading = false.obs;

  void acceptPolicy() {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 1), () {
      isLoading.value = false;
      Get.offAllNamed('/generalSettingsScreen');
    });
  }
}
