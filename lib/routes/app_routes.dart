import 'package:elad_giserman/features/auth/forget_password/screen/forget_password_screen.dart';
import 'package:elad_giserman/features/auth/forget_password/screen/reset_password_screen.dart';
import 'package:elad_giserman/features/auth/sign_in/screens/sign_in_screen.dart';
import 'package:elad_giserman/features/auth/sign_up/screen/sign_up_screen.dart';
import 'package:elad_giserman/features/home/home/screen/home_screen.dart';
import 'package:elad_giserman/features/nav_bar/screen/nav_bar_screen.dart';
import 'package:elad_giserman/features/profile/general_settings/about/screen/about_screen.dart';
import 'package:elad_giserman/features/profile/general_settings/helps/screen/help_screen.dart';
import 'package:elad_giserman/features/profile/general_settings/privacy_policy/screen/privacy_policy_screen.dart';
import 'package:elad_giserman/features/profile/general_settings/term_of_use/screen/terms_of_use_screen.dart';
import 'package:elad_giserman/features/profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:elad_giserman/features/profile/main/screen/profile_screen.dart';
import 'package:elad_giserman/features/profile/my_reservation/screen/reservation_history_screen.dart';
import 'package:elad_giserman/features/profile/subscriptions/screen/subscriptions_screen.dart';
import 'package:elad_giserman/features/profile/update_password/screen/update_password_screen.dart';
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
  static String redemptionHistoryScreen = "/redemptionHistoryScreen";
  static String generalSettingsScreen = "/generalSettingsScreen";
  static String notificationScreen = "/notificationScreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";
  static String helpScreen = "/helpScreen";
  static String termOfUseScreen = "/termOfUseScreen";
  static String aboutScreen = "/aboutScreen";
  static String updatePasswordScreen = "/updatePasswordScreen";

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
  static String getDetailsScreen() => detailsScreen;
  static String getRedemptionHistoryScreen() => redemptionHistoryScreen;
  static String getGeneralSettingsScreen() => generalSettingsScreen;
  static String getNotificationScreen() => notificationScreen;
  static String getPrivacyPolicyScreen() => privacyPolicyScreen;
  static String getHelpScreen() => helpScreen;
  static String getTermOfUseScreen() => termOfUseScreen;
  static String getAboutScreen() => aboutScreen;
  static String getUpdatePasswordScreen() => updatePasswordScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(name: navBarScreen, page: () => NavbarScreen()),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.upToDown,
    ),

    GetPage(
      name: venueScreen,
      page: () => VenueScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: editProfileScreen,
      page: () => EditProfileScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: reservationScreen,
      page: () => ReservationHistoryScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: subscriptionScreen,
      page: () => SubscriptionsScreen(),
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
    GetPage(
      name: helpScreen,
      page: () => HelpScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: termOfUseScreen,
      page: () => TermsOfUseScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: aboutScreen,
      page: () => AboutScreen(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: updatePasswordScreen,
      page: () => UpdatePasswordScreen(),
      transition: Transition.upToDown,
    ),
  ];
}
