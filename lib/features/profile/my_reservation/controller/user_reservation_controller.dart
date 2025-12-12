import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/profile/my_reservation/model/reservation_model.dart';
import 'package:elad_giserman/features/profile/my_reservation/service/reservation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserReservationController extends GetxController {
  final ReservationService _reservationService = ReservationService();

  final Rx<ReservationResponse?> reservationResponse = Rx(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  @override
  void onReady() {
    super.onReady();
    // Refresh data when screen is shown
    if (isLoggedIn.value) {
      fetchReservations();
    }
  }

  Future<void> checkLoginStatus() async {
    final token = await SharedPreferencesHelper.getAccessToken();
    isLoggedIn.value = token != null && token.isNotEmpty;

    if (isLoggedIn.value) {
      fetchReservations();
    }
  }

  Future<void> fetchReservations() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found. Please login again.';
        isLoggedIn.value = false;
        isLoading.value = false;
        return;
      }

      final response = await _reservationService.fetchReservations(token);

      if (response != null) {
        reservationResponse.value = response;
        if (kDebugMode) {
          print("✅ Reservations loaded successfully");
        }
      } else {
        errorMessage.value = 'Failed to load reservations';
        if (kDebugMode) {
          print("❌ Failed to load reservations");
        }
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      if (kDebugMode) {
        print("❌ Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  List<Reservation> get lastWeekReservations =>
      reservationResponse.value?.data.lastWeek ?? [];

  List<Reservation> get thisWeekReservations =>
      reservationResponse.value?.data.thisWeek ?? [];

  bool get hasReservations =>
      lastWeekReservations.isNotEmpty || thisWeekReservations.isNotEmpty;

  Future<bool> deleteReservation(String reservationId) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Please login to delete a reservation';
        return false;
      }

      final success = await _reservationService.deleteReservation(
        reservationId,
        token,
      );

      if (success) {
        if (kDebugMode) {
          print("✅ Reservation deleted successfully");
        }
        // Refresh the list after deletion
        await fetchReservations();
        // Trigger GetBuilder rebuild
        update();
        return true;
      } else {
        errorMessage.value = 'Failed to delete reservation';
        if (kDebugMode) {
          print("❌ Failed to delete reservation");
        }
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while deleting: $e';
      if (kDebugMode) {
        print("❌ Error deleting reservation: $e");
      }
      return false;
    }
  }
}
