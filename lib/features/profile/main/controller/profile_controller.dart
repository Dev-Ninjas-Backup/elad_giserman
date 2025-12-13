// ignore_for_file: avoid_print

import 'dart:io';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/auth/sign_up/service/auth_service.dart';
import 'package:elad_giserman/features/nav_bar/controller/nav_bar_controller.dart';
import 'package:elad_giserman/features/profile/main/model/profile_model.dart';
import 'package:elad_giserman/features/profile/main/service/profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  var selectedImagePath = ''.obs;

  var isLoading = false.obs;
  var isSaving = false.obs;
  var isInitialLoad = true.obs;
  var profile = Rx<ProfileModel?>(null);
  var isLoggingOut = false.obs;
  final service = ProfileService();
  final authService = AuthService();

  @override
  void onInit() {
    loadProfile(showLoading: true);
    try {
      final NavbarController navbarController = Get.find();
      ever(navbarController.selectedIndex, (index) {
        if (index == 4) {
          // Profile tab is selected, reload the data silently
          loadProfile(showLoading: false);
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(
          "NavbarController not found, profile reload on tab change disabled",
        );
      }
    }

    super.onInit();
  }

  var selectedCountryCode = "+880".obs;

  final countryCodes = ["+880", "+91", "+1", "+44", "+61"];

  Future<void> loadProfile({bool showLoading = true}) async {
    // Only show loading on initial load
    if (showLoading && isInitialLoad.value) {
      isLoading.value = true;
    }

    try {
      String? token = await SharedPreferencesHelper.getAccessToken();

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print("⛔ No token found");
        }
        isLoading.value = false;
        return;
      }

      final data = await service.fetchProfile(token);

      profile.value = data;

      // Populate text fields with profile data
      if (data != null) {
        nameController.text = data.name;
        phoneController.text = data.mobile ?? '';

        // Parse country code from phone number if available
        if (data.mobile != null && data.mobile!.isNotEmpty) {
          // Try to extract country code from the phone number
          for (String code in countryCodes) {
            if (data.mobile!.startsWith(code)) {
              selectedCountryCode.value = code;
              break;
            }
          }
        }
      }

      isLoading.value = false;
      isInitialLoad.value = false;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error loading profile: $e");
      }
      isLoading.value = false;
      isInitialLoad.value = false;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> updateProfile() async {
    isSaving.value = true;

    String? token = await SharedPreferencesHelper.getAccessToken();

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'No authentication token found');
      isSaving.value = false;
      return;
    }

    File? imageFile = selectedImagePath.isNotEmpty
        ? File(selectedImagePath.value)
        : null;

    final success = await service.updateProfile(
      token: token,
      name: nameController.text,
      phone: phoneController.text,
      imageFile: imageFile,
    );

    isSaving.value = false;

    if (success) {
      // Reload profile data before navigating
      await loadProfile(showLoading: false);
      // Clear selected image path after successful update
      selectedImagePath.value = '';

      Get.snackbar('Success', 'Profile updated successfully');

      // Navigate to navbar with profile tab (index 4)
      Get.offAllNamed('/navBarScreen');

      // Try to set navbar to profile tab
      try {
        final NavbarController navbarController = Get.find();
        navbarController.changeTabIndex(4);
      } catch (e) {
        if (kDebugMode) {
          print("Could not navigate to profile tab: $e");
        }
      }
    } else {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    try {
      await authService.logout();
      // Clear local profile data
      profile.value = null;
      nameController.clear();
      phoneController.clear();
      selectedImagePath.value = '';

      Get.snackbar('Success', 'Logged out successfully');
      // Navigate to login screen
      Get.offAllNamed('/loginScreen');
    } catch (e) {
      print('❌ Logout Error: $e');
      Get.snackbar('Error', 'Failed to logout');
    } finally {
      isLoggingOut.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
