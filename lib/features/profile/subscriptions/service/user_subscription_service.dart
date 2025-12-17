// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/profile/subscriptions/model/user_subscription_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserSubscriptionService {
  static const String _userSubscriptionUrl =
      'https://api.yamiz.org/api/subscription/me';

  Future<UserSubscriptionResponse?> fetchUserSubscription() async {
    try {
      if (kDebugMode) {
        print('🔄 UserSubscriptionService: Starting API request...');
        print('   URL: $_userSubscriptionUrl');
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getAccessToken();
      if (kDebugMode) {
        print(
          '   Token retrieved: ${token != null ? 'Yes (${token.length} chars)' : 'No'}',
        );
      }

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print('❌ No token available - cannot fetch user subscription');
        }
        return null;
      }

      final response = await http.get(
        Uri.parse(_userSubscriptionUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (kDebugMode) {
        print('📦 User Subscription API Response:');
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

        final userSubscriptionResponse = UserSubscriptionResponse.fromJson(
          jsonResponse,
        );

        if (kDebugMode) {
          print('✅ User subscription fetched successfully');
          print('   Status: ${userSubscriptionResponse.data.status}');
          print('   Plan: ${userSubscriptionResponse.data.plan.title}');
          print(
            '   Price: ${userSubscriptionResponse.data.plan.formattedPrice}/${userSubscriptionResponse.data.plan.billingPeriod}',
          );
          print(
            '   Started: ${userSubscriptionResponse.data.period.startedAt}',
          );
          print('   Ends: ${userSubscriptionResponse.data.period.endedAt}');
          print(
            '   Remaining Days: ${userSubscriptionResponse.data.period.remainingDays}',
          );
        }

        return userSubscriptionResponse;
      } else {
        if (kDebugMode) {
          print('❌ Failed to fetch user subscription: ${response.statusCode}');
          print('   Response: ${response.body}');
        }
        return null;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Error fetching user subscription: $e');
        print('   Error type: ${e.runtimeType}');
        print('   Stack Trace:');
        print(stackTrace);
      }
      return null;
    }
  }
}
