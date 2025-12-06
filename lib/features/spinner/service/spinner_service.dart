import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SpinnerService {
  Future<http.Response> submitSpinResult({required int result}) async {
    final url = Uri.parse(Urls.spinHistory);
    final token = await SharedPreferencesHelper.getAccessToken();

    if (kDebugMode) {
      print("🎯 Submitting spin result: $result");
      print("🎯 Token exists: ${token != null && token.isNotEmpty}");
      print("🎯 API URL: ${url.toString()}");
    }

    final body = jsonEncode({"result": result});

    if (kDebugMode) {
      print("🎯 Request body: $body");
    }

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      if (kDebugMode) {
        print("✅ SPIN RESULT STATUS: ${response.statusCode}");
        print("✅ SPIN RESULT BODY: ${response.body}");
        print("✅ SPIN RESULT HEADERS: ${response.headers}");
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error submitting spin result: $e");
      }
      throw Exception("Network error: $e");
    }
  }
}
