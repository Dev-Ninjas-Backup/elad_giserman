// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(Urls.register);

    final body = jsonEncode({
      "email": email,
      "username": username,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      return response;
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  Future<void> logout() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.post(
        Uri.parse(Urls.logout),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🚪 Logout API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Logged out successfully');
        // Clear local token and user data
        await SharedPreferencesHelper.clearAll();
      } else {
        print('❌ Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Logout Error: $e');
      // Still clear local data on error to ensure user is logged out locally
      await SharedPreferencesHelper.clearAll();
    }
  }
}
