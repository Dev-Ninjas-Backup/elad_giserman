import 'package:get/get.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";

  static String getLoginScreen() => loginScreen;

  static List<GetPage> routes = [
    // GetPage(name: loginScreen, page: () => const HomeScreen()),
  ];
}
