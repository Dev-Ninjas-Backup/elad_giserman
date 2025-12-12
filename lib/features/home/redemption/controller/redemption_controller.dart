import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RedemptionController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;

  Future<bool> redeemCode(String code) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Please login to redeem a code';
        isLoading.value = false;
        return false;
      }

      final url = Uri.parse('${Urls.baseUrl}/user-info/redeem/$code');

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("✅ Redemption successful: ${response.statusCode}");
          print("Response: $jsonResponse");
        }
        successMessage.value =
            jsonResponse['message'] ?? 'Code redeemed successfully!';
        isLoading.value = false;
        return true;
      } else {
        if (kDebugMode) {
          print("❌ Redemption failed: ${response.statusCode}");
          print("Response: ${response.body}");
        }
        final jsonResponse = jsonDecode(response.body);
        errorMessage.value = jsonResponse['message'] ?? 'Failed to redeem code';
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error redeeming code: $e");
      }
      errorMessage.value = 'An error occurred: $e';
      isLoading.value = false;
      return false;
    }
  }
}
