import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/profile/redemption_history/model/redemption_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RedemptionHistoryService {
  Future<List<RedemptionItem>> fetchRedeemedItems() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('${Urls.baseUrl}/user-info/redeemed');

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
          print("✅ Fetch redeemed items: ${response.statusCode}");
          print("Response: $jsonResponse");
        }

        final List<dynamic> dataList =
            jsonResponse['data'] as List<dynamic>? ?? [];
        return dataList
            .map(
              (item) => RedemptionItem.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        if (kDebugMode) {
          print("❌ Failed to fetch redeemed items: ${response.statusCode}");
          print("Response: ${response.body}");
        }
        throw Exception('Failed to fetch redeemed items');
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error fetching redeemed items: $e");
      }
      rethrow;
    }
  }
}
