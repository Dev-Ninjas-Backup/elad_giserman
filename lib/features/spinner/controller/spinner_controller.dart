import 'package:get/get.dart';

class SpinnerController extends GetxController {
  final List<String> items = [
    '🍎 Apple',
    '🎁 Gift',
    '🏆 Trophy',
    '💎 Diamond',
    '🎫 Ticket',
    '💰 Cash',
    '⭐ Star',
    '🎉 Party',
  ];

  final selectedIndex = (-1).obs;
  final isSpinning = false.obs;

  void setSelected(int index) {
    selectedIndex.value = index;
    isSpinning.value = false;
  }

  void setSpinning(bool val) {
    isSpinning.value = val;
  }

  String get selectedText {
    final i = selectedIndex.value;
    if (i < 0 || i >= items.length) return '';
    return items[i];
  }
}
