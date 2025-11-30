import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/features/profile/main/model/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<ProfileModel?> fetchProfile(String token) async {
    final url = Uri.parse(Urls.myProfile);

    final response = await http.get(
      url,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print("Fetch profile: ${response.statusCode}");
      }
      return ProfileModel.fromJson(jsonResponse["data"]);
    } else {
      if (kDebugMode) {
        print("❌ Failed to fetch profile: ${response.statusCode}");
      }
      return null;
    }
  }
}
