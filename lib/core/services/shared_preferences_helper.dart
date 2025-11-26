import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';

  static const String _selectedGameKey = 'selected_game';

  static Future<void> saveTokenAndRole(
    String token,
    String role,
    var userId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setString('userId', userId.toString());
    await prefs.setBool('isLogin', true);
  }

  static Future<void> isSubscribed(dynamic isSubscribed) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isSubscribed != null) {
      await prefs.setString('isSubscribed', isSubscribed.toString());
    }
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<String?> getSubscriptionStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('isSubscribed');
  }

  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> clearAll() async {
    await clearAllData();
  }

  static Future<void> clearAllAppData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove('isLogin');
  }

  static Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static const String _showOnboardKey = 'showOnboard';

  static Future<void> setShowOnboard(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showOnboardKey, value);
  }

  static Future<bool> getShowOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showOnboardKey) ?? false;
  }

  static Future<void> saveSelectedGame(String game) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedGameKey, game);
  }

  static Future<String?> getSelectedGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedGameKey);
  }

  static Future<void> saveEmailPrivacy(bool isPrivate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEmailPrivate', isPrivate);
  }

  static Future<bool> getEmailPrivacy() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isEmailPrivate') ?? false;
  }
}
