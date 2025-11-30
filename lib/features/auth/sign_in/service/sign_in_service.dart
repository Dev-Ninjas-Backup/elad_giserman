import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:http/http.dart' as http;

class SignInService {
  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(Urls.login);

    final body = jsonEncode({"email": email, "password": password});

    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
  }
}
