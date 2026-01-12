import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/end_points.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;
  var isSpinAvailable = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdminActivity();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  // Get the bottom navigation index for display
  int getBottomNavIndex() {
    if (!isSpinAvailable.value) {
      // When spin is hidden, adjust the display index
      if (selectedIndex.value > 2) {
        return selectedIndex.value - 1;
      }
    }
    return selectedIndex.value;
  }

  Future<void> fetchAdminActivity() async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      Map<String, String> headers = {'Content-Type': 'application/json'};

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(
        Uri.parse(Urls.adminActivity),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 200 &&
            data['data'] != null &&
            data['data'].isNotEmpty) {
          final adminData = data['data'][0];
          isSpinAvailable.value = adminData['isSpinAvaiable'] ?? false;
        } else {
          isSpinAvailable.value = false;
        }
      } else {
        isSpinAvailable.value = false;
        print('Failed to fetch admin activity: ${response.statusCode}');
      }
    } catch (e) {
      isSpinAvailable.value = false;
      print('Error fetching admin activity: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
