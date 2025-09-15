import 'package:elad_giserman/features/auth/forget_password/screen/forget_password_screen.dart';
import 'package:elad_giserman/features/auth/forget_password/screen/reset_password_screen.dart';
import 'package:elad_giserman/features/auth/sign_in/screens/sign_in_screen.dart';
import 'package:elad_giserman/features/auth/sign_up/screen/sign_up_screen.dart';
import 'package:elad_giserman/features/home/home/screen/home_screen.dart';
import 'package:elad_giserman/features/nav_bar/screen/nav_bar_screen.dart';
import 'package:elad_giserman/features/profile/screen/edit_profile_screen.dart';
import 'package:elad_giserman/features/profile/screen/profile_screen.dart';
import 'package:elad_giserman/features/splash/screens/splash_screen.dart';
import 'package:elad_giserman/features/venue/screen/venue_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String signInScreen = "/signInScreen";
  static String signUpScreen = "/signUpScreen";
  static String forgetPasswordScreen = "/forgetPasswordScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String navBarScreen = "/navBarScreen";
  static String homeScreen = "/homeScreen";
  static String venueScreen = "/venueScreen";
  static String profileScreen = "/profileScreen";
  static String editProfileScreen = "/editProfileScreen";

  static String getSplashScreen() => splashScreen;
  static String getSignInScreen() => signInScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getForgetPasswordScreen() => forgetPasswordScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;
  static String getNavBarScreen() => navBarScreen;
  static String getHomeScreen() => homeScreen;
  static String getVenueScreen() => venueScreen;
  static String getProfileScreen() => profileScreen;
  static String getEditProfileScreen() => editProfileScreen;

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
    GetPage(
      name: forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(name: navBarScreen, page: () => const NavbarScreen()),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: venueScreen,
      page: () => const VenueScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
      transition: Transition.upToDown,
    ),
  ];
}
