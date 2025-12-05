import 'dart:convert';
import 'dart:io';
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

  Future<bool> updateProfile({
    required String token,
    required String name,
    required String phone,
    File? imageFile,
  }) async {
    final url = Uri.parse(Urls.updateProfile);
    
    var request = http.MultipartRequest('PATCH', url);
    request.headers['Authorization'] = 'Bearer $token';
    
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    
    if (imageFile != null && imageFile.existsSync()) {
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
    }
    
    try {
      final response = await request.send();
      
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("✅ Profile updated successfully");
        }
        return true;
      } else {
        if (kDebugMode) {
          print("❌ Failed to update profile: ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error updating profile: $e");
      }
      return false;
    }
  }
}
