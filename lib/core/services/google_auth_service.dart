import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:flutter/foundation.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Sign in with Google and get ID token
  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      if (kDebugMode) {
        print('Google Sign-In Error: $error');
      }

      // Check if it's a configuration error
      if (error.toString().contains('DEVELOPER_ERROR') ||
          error.toString().contains('INTERNAL_ERROR')) {
        throw Exception(
          'Google Sign-In not properly configured. Please add google-services.json and configure OAuth 2.0 client.',
        );
      }

      return null;
    }
  }

  // Get ID token from Google account
  static Future<String?> getIdToken(GoogleSignInAccount account) async {
    try {
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      return authentication.idToken;
    } catch (error) {
      print('Error getting ID token: $error');
      return null;
    }
  }

  // Send ID token to backend for authentication
  static Future<http.Response> authenticateWithBackend(String idToken) async {
    final url = Uri.parse(Urls.googleLogin);

    final body = jsonEncode({"idToken": idToken});

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

  // Complete Google Sign-In flow
  static Future<http.Response?> performGoogleSignIn() async {
    try {
      // Step 1: Sign in with Google
      final GoogleSignInAccount? account = await signInWithGoogle();
      if (account == null) {
        throw Exception("Google sign-in was cancelled");
      }

      // Step 2: Get ID token
      final String? idToken = await getIdToken(account);
      if (idToken == null) {
        throw Exception("Failed to get ID token");
      }

      // Step 3: Send to backend
      final response = await authenticateWithBackend(idToken);
      return response;
    } catch (e) {
      print('Google Sign-In Flow Error: $e');
      rethrow;
    }
  }

  // Sign out from Google
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print('Google Sign-Out Error: $error');
    }
  }
}
