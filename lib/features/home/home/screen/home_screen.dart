import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/home/home/controller/home_ads_controller.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/home/widgets/home_app_bar.dart';
import 'package:elad_giserman/features/home/home/widgets/popular_near_widget.dart';
import 'package:elad_giserman/features/home/home/widgets/recommended_venue.dart';
import 'package:elad_giserman/features/home/home/widgets/vip_features_widget.dart';
import 'package:elad_giserman/features/home/twist/screens/twist_screen.dart';
import 'package:elad_giserman/features/home/twist/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final HomeAdsController adsController = Get.put(HomeAdsController());

    final selectedTab = 0.obs;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar(),
            Obx(() {
              final ad = adsController.bannerAd1.value;
              if (ad == null) return const SizedBox.shrink();
              return SizedBox(
                width: ad.size.width.toDouble(),
                height: ad.size.height.toDouble(),
                child: AdWidget(ad: ad),
              );
            }),
            const SizedBox(height: 12),
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  TabWidget(
                    image: IconPath.tab1,
                    title: 'tab_restaurants'.tr,
                    iconColor: selectedTab.value == 0
                        ? Colors.white
                        : Colors.black,
                    fontColor: selectedTab.value == 0
                        ? Colors.white
                        : Colors.black,
                    buttonColor: selectedTab.value == 0
                        ? AppColors.primaryFontColor
                        : const Color(0xFFF2F2F2),
                    onTap: () => selectedTab.value = 0,
                  ),
                  const SizedBox(width: 10),
                  TabWidget(
                    image: IconPath.tab2,
                    title: 'tab_cafe'.tr,
                    iconColor: selectedTab.value == 1
                        ? Colors.white
                        : Colors.black,
                    fontColor: selectedTab.value == 1
                        ? Colors.white
                        : Colors.black,
                    buttonColor: selectedTab.value == 1
                        ? AppColors.primaryFontColor
                        : const Color(0xFFF2F2F2),
                    onTap: () => selectedTab.value = 1,
                  ),
                  const SizedBox(width: 10),
                  TabWidget(
                    image: IconPath.tab3,
                    title: 'tab_bar'.tr,
                    iconColor: selectedTab.value == 2
                        ? Colors.white
                        : Colors.black,
                    fontColor: selectedTab.value == 2
                        ? Colors.white
                        : Colors.black,
                    buttonColor: selectedTab.value == 2
                        ? AppColors.primaryFontColor
                        : const Color(0xFFF2F2F2),
                    onTap: () => selectedTab.value = 2,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.to(TwistScreen()),
                    child: Text(
                      'see_all'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.fontColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => SizedBox(
                      height: 320,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.restaurants
                            .where(
                              (item) =>
                                  item.category ==
                                  _getCategory(selectedTab.value),
                            )
                            .length,
                        separatorBuilder: (_, __) => const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          final filteredItems = controller.restaurants
                              .asMap()
                              .entries
                              .where(
                                (entry) =>
                                    entry.value.category ==
                                    _getCategory(selectedTab.value),
                              )
                              .toList();
                          final item = filteredItems[index].value;
                          final originalIndex = filteredItems[index].key;
                          return PopularNearWidget(
                            image: item.image,
                            title: item.title,
                            subTitle: item.subTitle,
                            rating: item.rating,
                            reviewNum: item.reviewNum,
                            category: item.category,
                            isFavorite: item.isFavorite,
                            onFavoriteTap: () =>
                                controller.toggleFavorite(originalIndex),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Obx(() {
                      final ad = adsController.bannerAd3.value;
                      if (ad == null) return const SizedBox.shrink();
                      return SizedBox(
                        width: ad.size.width.toDouble(),
                        height: ad.size.height.toDouble(),
                        child: AdWidget(ad: ad),
                      );
                    }),
                  ),
                  VipFeaturesWidget(),
                  const SizedBox(height: 20),
                  Center(
                    child: Obx(() {
                      final ad = adsController.bannerAd2.value;
                      if (ad == null) return const SizedBox.shrink();
                      return SizedBox(
                        width: ad.size.width.toDouble(),
                        height: ad.size.height.toDouble(),
                        child: AdWidget(ad: ad),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'recommended_venues'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.offNamed('/venueScreen'),
                        child: Text(
                          'see_all'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Obx(
                    () => ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.recommended.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final item = controller.recommended[index];
                        return RecommendedVenue(
                          image: item.image,
                          title: item.title,
                          description: item.description,
                          location: item.location,
                          isFavorite: item.isFavorite,
                          onFavoriteTap: () =>
                              controller.toggleRecommendedFavorite(index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategory(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 'Restaurant';
      case 1:
        return 'Cafe';
      case 2:
        return 'Bar';
      default:
        return 'Restaurant';
    }
  }
}
