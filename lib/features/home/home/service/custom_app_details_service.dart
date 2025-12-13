import 'dart:convert';
import 'package:elad_giserman/features/home/home/model/custom_app_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CustomAppDetailsService {
  static const String baseUrl = 'http://31.97.125.159:5050/api/platform';

  Future<CustomAppDetails?> fetchCustomAppDetails() async {
    try {
      final url = Uri.parse('$baseUrl/customAppDetails');

      final response = await http.get(
        url,
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("✅ Custom app details fetched: ${response.statusCode}");
        }
        final customAppResponse = CustomAppDetailsResponse.fromJson(
          jsonResponse,
        );
        return customAppResponse.data;
      } else {
        if (kDebugMode) {
          print("❌ Failed to fetch custom app details: ${response.statusCode}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error fetching custom app details: $e");
      }
      return null;
    }
  }
}
