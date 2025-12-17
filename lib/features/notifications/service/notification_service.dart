import 'package:elad_giserman/features/notifications/model/notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';

class NotificationService {
  final String _baseUrl = 'https://api.yamiz.org/api';

  Future<NotificationResponse> fetchNotifications() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('Access token not found');
      }

      if (kDebugMode) {
        print(
          '📲 Fetching notifications from $_baseUrl/user-info/notifications',
        );
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/user-info/notifications'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print('📲 Response status: ${response.statusCode}');
        print('📲 Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NotificationResponse.fromJson(data);
      } else {
        throw Exception(
          'Failed to fetch notifications: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching notifications: $e');
      }
      rethrow;
    }
  }
}
