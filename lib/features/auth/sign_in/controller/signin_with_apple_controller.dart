

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Future<UserCredential> signInWithApple() async {
//   final appleCredential = await SignInWithApple.getAppleIDCredential(
//     scopes: [
//       AppleIDAuthorizationScopes.email,
//       AppleIDAuthorizationScopes.fullName,
//     ],
//   );

//   // Print the ID token
//   print("Apple ID Token new: ${appleCredential.identityToken}");

//   final oauthCredential = OAuthProvider("apple.com").credential(
//     idToken: appleCredential.identityToken,
//     accessToken: appleCredential.authorizationCode,
//   );

//   return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
// }


// import 'dart:convert';
// import 'package:elad_giserman/routes/app_routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';

// Future<void> signInWithAppleAndSendToServer() async {
//   try {
//     // 1️⃣ Sign in with Apple
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );

//     final idToken = appleCredential.identityToken;

//     print("Apple ID Token: $idToken"); // optional for debug

//     if (idToken == null) {
//       print("Apple ID Token is null!");
//       return;
//     }

//     // 2️⃣ Optionally sign in to Firebase
//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: idToken,
//       accessToken: appleCredential.authorizationCode,
//     );

//     await FirebaseAuth.instance.signInWithCredential(oauthCredential);

//     // 3️⃣ Send token to your backend
//     final url = Uri.parse("http://31.97.125.159:5050/api/auth/google-login");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"idToken": idToken}),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Server response: ${response.body}");

//       // 4️⃣ Navigate to main screen
//       Get.offAllNamed(AppRoute.navBarScreen);
//     } else {
//       print("Failed to send token. Status code: ${response.body}");
//     }
//   } catch (e) {
//     print("Error signing in with Apple: $e");
//   }
// }



// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../core/services/end_points.dart';

Future<void> signInWithAppleAndSendToServer() async {
  try {
    // 1️⃣ Sign in with Apple
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    if (appleCredential.identityToken == null) {
      print("Apple ID Token is null!");
      return;
    }

    // 2️⃣ Sign in to Firebase using Apple credential
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    // 3️⃣ Get Firebase ID token (this is what your backend expects)
    final firebaseIdToken = await userCredential.user!.getIdToken();
    print("Firebase ID Token final: $firebaseIdToken");

    // 4️⃣ Send Firebase ID token to your backend
    final url = Uri.parse("${Urls.baseUrl}/auth/google-login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idToken": firebaseIdToken}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Server response1: ${response.body}");

      final data = jsonDecode(response.body);


        final token = data["data"]["token"];
        final user = data["data"]["user"];

        final role = user["role"] ?? "USER";
        final userId = user["id"];

        await SharedPreferencesHelper.saveTokenAndRole(token, role, userId);

      // 5️⃣ Navigate to main screen
      Get.offAllNamed(AppRoute.navBarScreen);
    } else {
      print(
          "Failed to send token. Status code: ${response.statusCode}, body: ${response.body}");
    }
  } catch (e) {
    print("Error signing in with Apple: $e");
  }
}
