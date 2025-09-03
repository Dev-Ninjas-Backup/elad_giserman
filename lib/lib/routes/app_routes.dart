import 'package:elad_giserman/lib/features/auth/sign_in/screens/sign_in_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String signInScreen = "/signInScreen";

  static String getSignInScreen() => signInScreen;

  static List<GetPage> routes = [
    GetPage(name: signInScreen, page: () => const SignInScreen()),
  ];
}
