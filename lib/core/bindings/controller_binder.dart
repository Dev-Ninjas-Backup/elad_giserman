import 'package:elad_giserman/features/profile/my_reservation/controller/user_reservation_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserReservationController());
  }
}
