import 'package:get/get.dart';

class TermsOfUseController extends GetxController {
  var isLoading = false.obs; // Reactive variable for button loading state

  void acceptTerms() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.offAllNamed('/generalSettingsScreen');
    });
  }
}
