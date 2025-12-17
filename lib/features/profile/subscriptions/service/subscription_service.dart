// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/profile/subscriptions/model/subscription_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SubscriptionService {
  static const String _subscriptionUrl =
      'https://api.yamiz.org/api/subscription';

  Future<SubscriptionResponse?> fetchSubscriptions() async {
    try {
      if (kDebugMode) {
        print('🔄 SubscriptionService: Starting API request...');
        print('   URL: $_subscriptionUrl');
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getAccessToken();
      if (kDebugMode) {
        print(
          '   Token retrieved: ${token != null ? 'Yes (${token.length} chars)' : 'No'}',
        );
      }

      final response = await http.get(
        Uri.parse(_subscriptionUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (kDebugMode) {
        print('📦 Subscription API Response:');
        print('   Status Code: ${response.statusCode}');
        print('   Response Length: ${response.body.length} bytes');
        if (response.statusCode != 200) {
          print('   ⚠️ Non-200 response received');
        }
        print('   Response Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('🔄 Parsing JSON response...');
        }
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        if (kDebugMode) {
          print('   JSON decoded successfully');
          print('   Success: ${jsonResponse['success']}');
          print('   Message: ${jsonResponse['message']}');
        }

        final subscriptionResponse = SubscriptionResponse.fromJson(
          jsonResponse,
        );

        if (kDebugMode) {
          print('✅ Subscriptions fetched successfully');
          print(
            '   Monthly Plan: ${subscriptionResponse.data.monthlyPlan?.title ?? 'None'}',
          );
          if (subscriptionResponse.data.monthlyPlan != null) {
            print(
              '     - Price: ${subscriptionResponse.data.monthlyPlan!.formattedPrice}',
            );
            print(
              '     - Discount: ${subscriptionResponse.data.monthlyPlan!.discountPercent}%',
            );
            print(
              '     - Benefits Count: ${subscriptionResponse.data.monthlyPlan!.benefits.length}',
            );
          }
          print(
            '   Yearly Plan: ${subscriptionResponse.data.yearlyPlan?.title ?? 'None'}',
          );
          if (subscriptionResponse.data.yearlyPlan != null) {
            print(
              '     - Price: ${subscriptionResponse.data.yearlyPlan!.formattedPrice}',
            );
          }
          print(
            '   Biannual Plan: ${subscriptionResponse.data.biannualPlan?.title ?? 'None'}',
          );
        }

        return subscriptionResponse;
      } else {
        if (kDebugMode) {
          print('❌ Failed to fetch subscriptions: ${response.statusCode}');
          print('   Response: ${response.body}');
        }
        return null;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Error fetching subscriptions: $e');
        print('   Error type: ${e.runtimeType}');
        print('   Stack Trace:');
        print(stackTrace);
      }
      return null;
    }
  }
}
