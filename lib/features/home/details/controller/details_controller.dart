import 'package:get/get.dart';

class DetailsController extends GetxController {
  var isExpanded = false.obs; // Reactive boolean for toggle state

  void toggleText() {
    isExpanded.value = !isExpanded.value; // Toggle the expanded state
  }
}
