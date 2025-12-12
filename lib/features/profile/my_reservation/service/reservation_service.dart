import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/features/profile/my_reservation/model/reservation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ReservationService {
  Future<ReservationResponse?> fetchReservations(String token) async {
    try {
      final url = Uri.parse(Urls.userReservation);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("✅ Fetch reservations: ${response.statusCode}");
          print("Response: $jsonResponse");
        }
        return ReservationResponse.fromJson(jsonResponse);
      } else {
        if (kDebugMode) {
          print("❌ Failed to fetch reservations: ${response.statusCode}");
          print("Response: ${response.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error fetching reservations: $e");
      }
      return null;
    }
  }

  Future<bool> deleteReservation(String reservationId, String token) async {
    try {
      final url = Uri.parse('${Urls.userReservation}/delete/$reservationId');

      final response = await http.delete(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        if (kDebugMode) {
          print("✅ Reservation deleted: ${response.statusCode}");
          print("Response: ${response.body}");
        }
        return true;
      } else {
        if (kDebugMode) {
          print("❌ Failed to delete reservation: ${response.statusCode}");
          print("Response: ${response.body}");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error deleting reservation: $e");
      }
      return false;
    }
  }
}
