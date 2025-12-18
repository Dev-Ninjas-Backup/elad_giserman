import 'package:elad_giserman/features/home/home/controller/custom_app_details_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final CustomAppDetailsController _appDetailsController =
      Get.find<CustomAppDetailsController>();

  @override
  void onInit() {
    super.onInit();
    // Ensure app details are loaded from the beginning
    _appDetailsController.fetchAppDetails();

    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed('/navBarScreen');
    });
  }

  String get logoUrl => _appDetailsController.logoUrl;
}
