import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/home/model/business_profile_model.dart';
import 'package:http/http.dart' as http;

class BusinessProfileService {
  Future<List<BusinessProfile>> getAllProfiles() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse(Urls.businessProfiles),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🏢 Get Business Profiles API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? [];

        final profiles = data
            .map((item) =>
                BusinessProfile.fromJson(item as Map<String, dynamic>))
            .toList();

        print('✅ Business Profiles Fetched: ${profiles.length} profiles');
        return profiles;
      } else {
        print('❌ Failed to fetch profiles: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Get Business Profiles Error: $e');
      return [];
    }
  }
}
