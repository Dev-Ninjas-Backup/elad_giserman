import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/home/model/business_profile_model.dart';
import 'package:get/get.dart';

class TwistController extends GetxController {
  final selectedTab = 0.obs;
  final searchQuery = ''.obs;
  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    // Reactively watch for changes in home controller data
    ever(homeController.businessProfiles, (_) {
      update(); // Trigger UI rebuild when profiles change
    });
    ever(homeController.categories, (_) {
      update(); // Trigger UI rebuild when categories change
    });
  }

  void changeTab(int index) {
    selectedTab.value = index;
    searchQuery.value = '';
  }

  List<BusinessProfile> get filteredProfiles {
    // Use profiles directly from home controller (reactive)
    final profiles = homeController.businessProfiles;
    
    // Get profiles for the selected category
    // selectedTab.value == 0 means "All" is selected
    final categoryProfiles = selectedTab.value == 0
        ? profiles // Show all profiles when "All" is selected
        : selectedTab.value - 1 < homeController.categories.length
            ? profiles
                  .where(
                    (profile) =>
                        profile.categoryId ==
                        homeController.categories[selectedTab.value - 1].id,
                  )
                  .toList()
            : profiles;

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
