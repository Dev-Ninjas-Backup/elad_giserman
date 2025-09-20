import 'package:elad_giserman/features/auth/forget_password/screen/forget_password_screen.dart';
import 'package:elad_giserman/features/auth/forget_password/screen/reset_password_screen.dart';
import 'package:elad_giserman/features/auth/sign_in/screens/sign_in_screen.dart';
import 'package:elad_giserman/features/auth/sign_up/screen/sign_up_screen.dart';
import 'package:elad_giserman/features/home/home/screen/home_screen.dart';
import 'package:elad_giserman/features/nav_bar/screen/nav_bar_screen.dart';
import 'package:elad_giserman/features/profile/general_settings/privacy_policy/screen/privacy_policy_screen.dart';
import 'package:elad_giserman/features/profile/subscriptions/screen/checkout_screen.dart';
import 'package:elad_giserman/features/profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:elad_giserman/features/profile/main/screen/profile_screen.dart';
import 'package:elad_giserman/features/profile/my_reservation/screen/reservation_history_screen.dart';
import 'package:elad_giserman/features/profile/subscriptions/screen/subscriptions_screen.dart';
import 'package:elad_giserman/features/splash/screens/splash_screen.dart';
import 'package:elad_giserman/features/venue/screen/venue_screen.dart';
import 'package:get/get.dart';
import '../features/profile/general_settings/main/screen/general_settings_screen.dart';
import '../features/notifications/screen/notifications_screen.dart';
import '../features/profile/redemption_history/screen/redemption_history_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String signInScreen = "/signInScreen";
  static String signUpScreen = "/signUpScreen";
  static String forgetPasswordScreen = "/forgetPasswordScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String navBarScreen = "/navBarScreen";
  static String homeScreen = "/homeScreen";
  static String detailsScreen = "/detailsScreen";
  static String venueScreen = "/venueScreen";
  static String profileScreen = "/profileScreen";
  static String editProfileScreen = "/editProfileScreen";
  static String reservationScreen = "/reservationScreen";
  static String subscriptionScreen = "/subscriptionScreen";
  static String checkoutScreen = "/checkoutScreen";
  static String redemptionHistoryScreen = "/redemptionHistoryScreen";
  static String generalSettingsScreen = "/generalSettingsScreen";
  static String notificationScreen = "/notificationScreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";

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
  static String getReservationScreen() => reservationScreen;
  static String getSubscriptionScreen() => subscriptionScreen;
  static String getcheckoutScreen() => checkoutScreen;
  static String getDetailsScreen() => detailsScreen;
  static String getRedemptionHistoryScreen() => redemptionHistoryScreen;
  static String getGeneralSettingsScreen() => generalSettingsScreen;
  static String getNotificationScreen() => notificationScreen;
  static String getPrivacyPolicyScreen() => privacyPolicyScreen;

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
    GetPage(
      name: reservationScreen,
      page: () => const ReservationHistoryScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: subscriptionScreen,
      page: () => const SubscriptionsScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: checkoutScreen,
      page: () => const CheckoutScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: redemptionHistoryScreen,
      page: () => RedemptionHistoryScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: generalSettingsScreen,
      page: () => GeneralSettingsScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: notificationScreen,
      page: () => NotificationsScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: privacyPolicyScreen,
      page: () => PrivacyPolicyScreen(),
      transition: Transition.upToDown,
    ),
  ];
}
