import 'package:elad_giserman/features/home/home/model/custom_app_details_model.dart';
import 'package:elad_giserman/features/home/home/service/custom_app_details_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CustomAppDetailsController extends GetxController {
  final CustomAppDetailsService _service = CustomAppDetailsService();

  final Rx<CustomAppDetails?> appDetails = Rx(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppDetails();
  }

  Future<void> fetchAppDetails() async {
    try {
      if (kDebugMode) {
        print("🔄 Starting to fetch custom app details...");
      }

      isLoading.value = true;
      errorMessage.value = '';

      final details = await _service.fetchCustomAppDetails();

      if (details != null) {
        appDetails.value = details;
        if (kDebugMode) {
          print("✅ App details loaded successfully!");
          print("   Title: ${details.title}");
          print("   Description: ${details.description}");
          print("📷 Logo URL: ${details.logo}");
          print("🎴 Banner Card: ${details.bannerCard}");
          print("🖼️  Banner Photo: ${details.bannerPhoto}");
        }
      } else {
        errorMessage.value = 'Failed to load app details';
        if (kDebugMode) {
          print("❌ Failed to load app details - service returned null");
        }
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      if (kDebugMode) {
        print("❌ Error fetching app details: $e");
      }
    } finally {
      isLoading.value = false;
      if (kDebugMode) {
        print("🏁 Fetch app details completed. Loading: ${isLoading.value}");
      }
    }
  }

  String get logoUrl {
    final url = appDetails.value?.logo ?? '';
    if (kDebugMode) {
      print(
        "🔍 Logo URL getter called - returning: ${url.isEmpty ? '(empty)' : url}",
      );
    }
    return url;
  }
}
