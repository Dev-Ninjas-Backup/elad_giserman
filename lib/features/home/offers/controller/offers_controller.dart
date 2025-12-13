import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/offers/models/offer_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OffersController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<OfferModel> offers = <OfferModel>[].obs;
  final RxBool isRedeemingOffer = false.obs;
  final RxString redeemErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Please login to view offers';
        isLoading.value = false;
        return;
      }

      final url = Uri.parse(
        'http://31.97.125.159:5050/api/business-profiles/approved',
      );

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
          print("✅ Offers fetched successfully: ${response.statusCode}");
        }

        if (jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          offers.value = data.map((json) => OfferModel.fromJson(json)).toList();
        }

        isLoading.value = false;
      } else {
        if (kDebugMode) {
          print("❌ Failed to fetch offers: ${response.statusCode}");
          print("Response: ${response.body}");
        }
        errorMessage.value = 'Failed to fetch offers';
        isLoading.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error fetching offers: $e");
      }
      errorMessage.value = 'Error: ${e.toString()}';
      isLoading.value = false;
    }
  }

  Future<bool> redeemOffer(String code, String offerId) async {
    try {
      isRedeemingOffer.value = true;
      redeemErrorMessage.value = '';

      if (kDebugMode) {
        print("🔄 Starting offer redemption...");
        print("Code: $code");
        print("Offer ID: $offerId");
      }

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print("❌ No authentication token found");
        }
        redeemErrorMessage.value = 'Please login to redeem an offer';
        isRedeemingOffer.value = false;
        return false;
      }

      final url = Uri.parse(
        'http://31.97.125.159:5050/api/user-info/redeem/$code',
      );

      if (kDebugMode) {
        print("📍 API URL: $url");
        print("📤 Sending request body: ${jsonEncode({'offerId': offerId})}");
      }

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({'offerId': offerId}),
      );

      if (kDebugMode) {
        print("📥 Response Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("✅ Offer redeemed successfully: ${response.statusCode}");
          print("✅ Response: $jsonResponse");
        }
        isRedeemingOffer.value = false;
        return true;
      } else {
        if (kDebugMode) {
          print("❌ Failed to redeem offer: ${response.statusCode}");
          print("❌ Response: ${response.body}");
        }
        final jsonResponse = jsonDecode(response.body);
        redeemErrorMessage.value =
            jsonResponse['message'] ?? 'Failed to redeem offer';
        isRedeemingOffer.value = false;
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Exception during offer redemption: $e");
      }
      redeemErrorMessage.value = 'Error: ${e.toString()}';
      isRedeemingOffer.value = false;
      return false;
    }
  }
}
