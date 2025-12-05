import 'dart:io';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
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
  var profile = Rx<ProfileModel?>(null);
  final service = ProfileService();

  @override
  void onInit() {
    loadProfile();
    super.onInit();
  }

  var selectedCountryCode = "+880".obs;

  final countryCodes = ["+880", "+91", "+1", "+44", "+61"];

  Future<void> loadProfile() async {
    isLoading.value = true;

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
      Get.snackbar('Success', 'Profile updated successfully');
      final navBarController = Get.find<NavbarController>();
      navBarController.changeTabIndex(0);
      Get.offNamed('/navBarScreen');
    } else {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
