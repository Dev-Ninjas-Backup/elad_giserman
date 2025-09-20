import 'package:get/get.dart';

class HelpController extends GetxController {
  RxInt expandedTile = (-1).obs;

  void toggleTile(int index) {
    expandedTile.value = expandedTile.value == index ? -1 : index;
  }
}
