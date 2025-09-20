import 'package:get/get.dart';

class AboutController extends GetxController {
  var isLoading = false.obs;

  void performAction() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }
}
