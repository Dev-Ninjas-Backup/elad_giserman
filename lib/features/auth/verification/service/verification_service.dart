import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VerificationService {
  // ------------ VERIFY OTP API ------------
  Future<http.Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse(Urls.verifyOtp);
    final body = jsonEncode({"email": email, "otp": otp});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (kDebugMode) {
        print("VERIFY OTP STATUS: ${response.statusCode}");
      }

      return response;
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  // ------------ RESEND OTP API ------------
  Future<http.Response> resendOtp({required String email}) async {
    final url = Uri.parse(Urls.resendOtp); // MAKE SURE THIS URL EXISTS

    final body = jsonEncode({"email": email});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (kDebugMode) {
        print("RESEND OTP STATUS: ${response.statusCode}");
      }

      return response;
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
