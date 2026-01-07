import 'dart:convert';
import 'dart:math';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/spinner/model/spin_table_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SpinnerService {
  static const String _spinTableUrl =
      'https://api.yamiz.org/api/platform/spin-table';

  Future<SpinTableResponse?> fetchSpinTable() async {
    try {
      if (kDebugMode) {
        print('🎡 SpinnerService: Fetching spin table data...');
        print('   URL: $_spinTableUrl');
      }

      final response = await http.get(
        Uri.parse(_spinTableUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print('📦 Spin Table API Response:');
        print('   Status Code: ${response.statusCode}');
        print('   Response Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final spinTableResponse = SpinTableResponse.fromJson(jsonResponse);

        if (kDebugMode) {
          print('✅ Spin table fetched successfully');
          print('   Items count: ${spinTableResponse.data.length}');
          for (var item in spinTableResponse.data) {
            print('   - ${item.useCase} (${item.probablity}%)');
          }
        }

        return spinTableResponse;
      } else {
        if (kDebugMode) {
          print('❌ Failed to fetch spin table: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching spin table: $e');
      }
      return null;
    }
  }

  Future<int> getWeightedRandomIndex(List<SpinTableItem> items) async {
    final math = Random();
    final totalProbability = items.fold(
      0,
      (sum, item) => sum + item.probablity,
    );
    int randomValue = math.nextInt(totalProbability);

    int cumulativeProbability = 0;
    for (int i = 0; i < items.length; i++) {
      cumulativeProbability += items[i].probablity;
      if (randomValue < cumulativeProbability) {
        if (kDebugMode) {
          print('🎯 Weighted random selected index: $i (${items[i].useCase})');
        }
        return i;
      }
    }

    return 0;
  }

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
