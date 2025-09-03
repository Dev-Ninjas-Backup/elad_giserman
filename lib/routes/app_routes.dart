import 'package:elad_giserman/features/auth/sign_in/screens/sign_in_screen.dart';
import 'package:elad_giserman/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String signInScreen = "/signInScreen";

  static String getSplashScreen() => splashScreen;
  static String getSignInScreen() => signInScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
  ];
}
