// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class UpdatePasswordService {
  Future<http.Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.post(
        Uri.parse(Urls.changePassword),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'password': currentPassword,
          'newPassword': newPassword,
        }),
      );

      print('🔐 Change Password API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      return response;
    } catch (e) {
      print('❌ Change Password Error: $e');
      rethrow;
    }
  }
}
