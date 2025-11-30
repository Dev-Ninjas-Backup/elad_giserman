import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ForgetPasswordService {
  Future<http.Response> sendForgetPasswordRequest(String email) async {
    final url = Uri.parse(Urls.forgetPassword);

    final body = jsonEncode({"email": email});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (kDebugMode) {
        print("FORGET PASSWORD STATUS: ${response.statusCode}");
        print("FORGET PASSWORD BODY: ${response.body}");
      }

      return response;
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
