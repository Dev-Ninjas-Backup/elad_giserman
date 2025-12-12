import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReservationController extends GetxController {
  RxString selectedDate = ''.obs;
  RxString selectedTime = ''.obs;
  RxInt selectedSeat = 0.obs;
  RxString phoneNumber = ''.obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void selectDate(String date) {
    selectedDate.value = date;
  }

  void selectTime(String time) {
    selectedTime.value = time;
  }

  void selectSeat(int seatNumber) {
    selectedSeat.value = seatNumber;
  }

  void setPhoneNumber(String phone) {
    phoneNumber.value = phone;
  }

  bool validateFields() {
    if (selectedDate.value.isEmpty) {
      errorMessage.value = 'Please select a date';
      return false;
    }
    if (selectedTime.value.isEmpty) {
      errorMessage.value = 'Please select a time';
      return false;
    }
    if (phoneNumber.value.isEmpty) {
      errorMessage.value = 'Please enter your phone number';
      return false;
    }
    return true;
  }

  Future<bool> submitReservation(String restaurantId) async {
    try {
      errorMessage.value = '';

      if (!validateFields()) {
        return false;
      }

      isLoading.value = true;

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Please login to make a reservation';
        isLoading.value = false;
        return false;
      }

      final url = Uri.parse(Urls.userReservation);

      final body = {
        'restaurntId': restaurantId,
        'date': selectedDate.value,
        'time': selectedTime.value,
        'phoneNumber': phoneNumber.value,
      };

      if (kDebugMode) {
        print('Submitting reservation: $body');
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print('✅ Reservation successful: ${response.statusCode}');
          print('Response: $jsonResponse');
        }
        return true;
      } else {
        final jsonResponse = jsonDecode(response.body);
        errorMessage.value =
            jsonResponse['message'] ?? 'Failed to create reservation';
        if (kDebugMode) {
          print('❌ Reservation failed: ${response.statusCode}');
          print('Response: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      if (kDebugMode) {
        print('❌ Error: $e');
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
