import 'package:elad_giserman/features/auth/sign_up/screen/verification_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      // Get.offNamed('/signInScreen');
      Get.to(VerificationScreen(verificationEmail: 'avijit@gmail.com'));
    });
  }
}
