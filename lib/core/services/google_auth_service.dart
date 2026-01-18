// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:flutter/foundation.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    forceCodeForRefreshToken: true,
  );

  // Sign in with Google and get ID token
  static Future<GoogleSignInAccount?> signInWithGoogle() async {

  
    try {
        await _googleSignIn.signOut();

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        debugPrint('✅ Google Email: ${account.email}');
        debugPrint('✅ Google Name: ${account.displayName}');
        debugPrint('✅ Google ID: ${account.id}');
        debugPrint('✅ Photo URL: ${account.photoUrl}');
      }
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

      // Sign in to Firebase using the Google credentials to obtain a Firebase ID token
      final oauthCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      print('Obtained Firebase ID token: $firebaseIdToken');
      return firebaseIdToken;
    } catch (error) {
      print('Error getting ID token: $error');
      return null;
    }
  }

  // Send ID token to backend for authentication
  static Future<http.Response> authenticateWithBackend(String idToken) async {
    final url = Uri.parse(Urls.googleLogin);

    debugPrint('Sending ID token to backend: $idToken');

    final body = jsonEncode({"idToken": idToken});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint('Backend response: ${response.body}');

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
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      print('Google Sign-Out Error: $error');
    }
  }
}
