import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/twist/controller/twist_controller.dart';
import 'package:elad_giserman/features/home/twist/widgets/recommended_tab.dart';
import 'package:elad_giserman/features/home/twist/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../details/screen/details_screen.dart';

class TwistScreen extends StatelessWidget {
  const TwistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final TwistController controller = Get.put(TwistController());
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(lable: 'twist_title'.tr, back: '/navBarScreen'),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              child: Column(
                children: [
                  SizedBox(
                    height: 42,
                    child: TextField(
                      onChanged: (value) => controller.updateSearchQuery(value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.search, size: 20),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        hintText: 'twist_search_hint'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // "All" tab
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TabWidget(
                              image: null,
                              title: 'all'.tr,
                              iconColor: controller.selectedTab.value == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontColor: controller.selectedTab.value == 0
                                  ? Colors.white
                                  : Colors.black,
                              buttonColor: controller.selectedTab.value == 0
                                  ? AppColors.primaryFontColor
                                  : const Color(0xFFF2F2F2),
                              onTap: () => controller.changeTab(0),
                            ),
                          ),
                          ...List.generate(
                            homeController.categories.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: TabWidget(
                                image: null,
                                title: homeController.categories[index].name,
                                iconColor: controller.selectedTab.value == index + 1
                                    ? Colors.white
                                    : Colors.black,
                                fontColor: controller.selectedTab.value == index + 1
                                    ? Colors.white
                                    : Colors.black,
                                buttonColor:
                                    controller.selectedTab.value == index + 1
                                    ? AppColors.primaryFontColor
                                    : const Color(0xFFF2F2F2),
                                onTap: () => controller.changeTab(index + 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      final filteredProfiles = controller.filteredProfiles;
                      if (filteredProfiles.isEmpty) {
                        return Center(
                          child: Text(
                            'no_results_found'.tr,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: filteredProfiles.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final profile = filteredProfiles[index];
                          return GestureDetector(
                            onTap: () => Get.to(() => DetailsScreen(profileId: profile.id)),
                            child: RecommendedTab(
                              image: profile.gallery.isNotEmpty
                                  ? profile.gallery.first.url
                                  : 'https://via.placeholder.com/300',
                              title: profile.title,
                              location: profile.location,
                              isFavorite: false,
                              onFavoriteTap: () {},
                              category: profile.category.name,
                              rating: profile.avgRating ?? 0.0,
                              reviewNum: profile.reviewCount,
                              profileId: profile.id,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
