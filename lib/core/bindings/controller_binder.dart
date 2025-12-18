import 'package:elad_giserman/features/home/home/controller/custom_app_details_controller.dart';
import 'package:elad_giserman/features/profile/main/controller/profile_controller.dart';
import 'package:elad_giserman/features/profile/my_reservation/controller/user_reservation_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomAppDetailsController(), permanent: true);
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => UserReservationController());
  }
}
