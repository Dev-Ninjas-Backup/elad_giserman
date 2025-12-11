// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/details/model/profile_detail_model.dart';
import 'package:http/http.dart' as http;

class ProfileDetailService {
  Future<BusinessProfileDetail?> getProfileDetail(String profileId) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse('${Urls.businessProfiles}/$profileId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('📋 Get Profile Detail API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final profileData = jsonResponse['data'];

        if (profileData != null) {
          final profile = BusinessProfileDetail.fromJson(
            profileData as Map<String, dynamic>,
          );
          print('✅ Profile Detail Fetched Successfully');
          return profile;
        }
      } else {
        print('❌ Failed to fetch profile detail: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Get Profile Detail Error: $e');
    }
    return null;
  }
}
