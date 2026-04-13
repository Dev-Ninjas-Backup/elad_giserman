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

  Future<bool> redeemCode(String ?code, {String? offerId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      if (kDebugMode) {
        print("🔄 Starting redemption..." "Code123: $code" "Offer ID: $offerId");
        print("Code123: $code");
        print("Offer ID: $offerId");
      }

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Please login to redeem a code';
        isLoading.value = false;
        return false;
      }

      final url = Uri.parse('${Urls.baseUrl}/user-info/redeem/$code');

      if (kDebugMode) {
        print("📍 API URL: $url");
      }

      final Map<String, dynamic> body = {};
      if (offerId != null && offerId.isNotEmpty) {
        body['offerId'] = offerId;
        if (kDebugMode) {
          print("📤 Request body: ${jsonEncode(body)}");
        }
      }

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: body.isNotEmpty ? jsonEncode(body) : null,
      );

      if (kDebugMode) {
        print("📥 Response Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("✅ Redemption successful: ${response.statusCode}");
          print("✅ Response: $jsonResponse");
        }
        successMessage.value =
            jsonResponse['message'] ?? 'Code redeemed successfully!';
        isLoading.value = false;
        return true;
      } else {
        if (kDebugMode) {
          print("❌ Redemption failed: ${response.statusCode}");
          print("❌ Response: ${response.body}");
        }
        final jsonResponse = jsonDecode(response.body);
        String errorMsg = jsonResponse['message'] ?? 'Failed to redeem code';
        
        // Replace technical error message with user-friendly message
        if (errorMsg.contains('Cannot POST') || response.statusCode == 404) {
          errorMsg = 'Code is Required';
        }
        
        errorMessage.value = errorMsg;
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Exception during redemption: $e");
      }
      errorMessage.value = 'An error occurred: $e';
      isLoading.value = false;
      return false;
    }
  }
}
