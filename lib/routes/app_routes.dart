import 'package:elad_giserman/features/auth/sign_in/screens/sign_in_screen.dart';
import 'package:elad_giserman/features/auth/sign_up/screen/sign_up_screen.dart';
import 'package:elad_giserman/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String signInScreen = "/signInScreen";
  static String signUpScreen = "/signUpScreen";

  static String getSplashScreen() => splashScreen;
  static String getSignInScreen() => signInScreen;
  static String getSignUpScreen() => signUpScreen;
  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: signInScreen,
      page: () => const SignInScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      transition: Transition.upToDown,
    ),
  ];
}
