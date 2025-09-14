import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/twist/controller/twist_controller.dart';
import 'package:elad_giserman/features/twist/widgets/recommended_tab.dart';
import 'package:elad_giserman/features/twist/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TwistScreen extends StatelessWidget {
  const TwistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final TwistController controller = Get.put(TwistController());

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(lable: 'Twist', back: '/navBarScreen'),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              child: Column(
                children: [
                  // Search Bar
                  SizedBox(
                    height: 42,
                    child: TextField(
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
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tabs
                  Obx(
                    () => Row(
                      children: [
                        TabWidget(
                          image: IconPath.tab1,
                          title: 'Restaurants',
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
                        const SizedBox(width: 10),
                        TabWidget(
                          image: IconPath.tab2,
                          title: 'Cafe',
                          iconColor: controller.selectedTab.value == 1
                              ? Colors.white
                              : Colors.black,
                          fontColor: controller.selectedTab.value == 1
                              ? Colors.white
                              : Colors.black,
                          buttonColor: controller.selectedTab.value == 1
                              ? AppColors.primaryFontColor
                              : const Color(0xFFF2F2F2),
                          onTap: () => controller.changeTab(1),
                        ),
                        const SizedBox(width: 10),
                        TabWidget(
                          image: IconPath.tab3,
                          title: 'Bar',
                          iconColor: controller.selectedTab.value == 2
                              ? Colors.white
                              : Colors.black,
                          fontColor: controller.selectedTab.value == 2
                              ? Colors.white
                              : Colors.black,
                          buttonColor: controller.selectedTab.value == 2
                              ? AppColors.primaryFontColor
                              : const Color(0xFFF2F2F2),
                          onTap: () => controller.changeTab(2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      List items;
                      if (controller.selectedTab.value == 0) {
                        items = controller.restaurants;
                      } else if (controller.selectedTab.value == 1) {
                        items = controller.cafes;
                      } else {
                        items = controller.bars;
                      }
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return RecommendedTab(
                            image: item['image'],
                            title: item['title'],
                            location: item['location'],
                            isFavorite: item['isFavorite'],
                            onFavoriteTap: () {
                              controller.toggleFavorite(
                                controller.selectedTab.value,
                                index,
                              );
                            },
                            category: item['category'],
                            rating: item['rating'],
                            reviewNum: item['reviewNum'],
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
