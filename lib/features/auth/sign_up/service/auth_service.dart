import 'dart:convert';

import 'package:elad_giserman/core/services/end_points.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(Urls.register);

    final body = jsonEncode({
      "email": email,
      "username": username,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      return response;
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
