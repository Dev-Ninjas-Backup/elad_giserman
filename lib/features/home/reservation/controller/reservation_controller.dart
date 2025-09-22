import 'package:get/get.dart';

class ReservationController extends GetxController {
  RxString selectedDate = ''.obs;
  RxString selectedTime = ''.obs;
  RxInt selectedSeat = 0.obs;

  void selectDate(String date) {
    selectedDate.value = date;
  }

  void selectTime(String time) {
    selectedTime.value = time;
  }

  void selectSeat(int seatNumber) {
    selectedSeat.value = seatNumber;
  }
}
