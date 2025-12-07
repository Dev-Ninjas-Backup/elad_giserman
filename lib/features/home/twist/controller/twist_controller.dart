import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/home/model/business_profile_model.dart';
import 'package:get/get.dart';

class TwistController extends GetxController {
  final selectedTab = 0.obs;
  final searchQuery = ''.obs;
  final businessProfiles = <BusinessProfile>[].obs;
  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    // Get business profiles from home controller
    businessProfiles.value = homeController.businessProfiles.toList();
  }

  void changeTab(int index) {
    selectedTab.value = index;
    searchQuery.value = '';
  }

  List<BusinessProfile> get filteredProfiles {
    // Get profiles for the selected category
    final categoryProfiles =
        selectedTab.value < homeController.categories.length
        ? businessProfiles
              .where(
                (profile) =>
                    profile.categoryId ==
                    homeController.categories[selectedTab.value].id,
              )
              .toList()
        : businessProfiles;

    // Filter by search query
    if (searchQuery.value.isEmpty) return categoryProfiles;
    return categoryProfiles.where((profile) {
      final title = profile.title.toLowerCase();
      final location = profile.location.toLowerCase();
      final query = searchQuery.value.toLowerCase().trim();
      return title.contains(query) || location.contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    if (query.trim().isNotEmpty || query.isEmpty) {
      searchQuery.value = query;
    }
  }
}
