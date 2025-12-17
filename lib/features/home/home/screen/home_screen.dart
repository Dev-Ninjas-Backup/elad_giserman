import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/home/controller/home_ads_controller.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/home/model/business_profile_model.dart';
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

    final selectedTab = (-1).obs; // -1 means show all categories

    // Fetch favorites on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMyFavorites();
    });

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
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    ...List.generate(
                      controller.categories.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TabWidget(
                          image: null,
                          title: controller.categories[index].name,
                          iconColor: selectedTab.value == index
                              ? Colors.white
                              : Colors.black,
                          fontColor: selectedTab.value == index
                              ? Colors.white
                              : Colors.black,
                          buttonColor: selectedTab.value == index
                              ? AppColors.primaryFontColor
                              : const Color(0xFFF2F2F2),
                          onTap: () => selectedTab.value = index,
                        ),
                      ),
                    ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => SizedBox(
                      height: 300,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: _getFilteredProfiles(
                          controller,
                          selectedTab.value,
                        ).length,
                        separatorBuilder: (_, __) => const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          final filteredProfiles = _getFilteredProfiles(
                            controller,
                            selectedTab.value,
                          );
                          final profile = filteredProfiles[index];

                          return Obx(
                            () => PopularNearWidget(
                              image: profile.gallery.isNotEmpty
                                  ? profile.gallery.first.url
                                  : 'https://via.placeholder.com/300',
                              title: profile.title,
                              subTitle: profile.location,
                              rating: double.parse(
                                ((profile.avgRating ?? 0.0).toStringAsFixed(1)),
                              ),
                              reviewNum: profile.reviewCount,
                              category: profile.category.name,
                              isFavorite: controller.isFavoriteBusiness(
                                profile.id,
                              ),
                              onFavoriteTap: () {
                                controller.toggleFavoriteBusiness(profile.id);
                              },
                              profileId: profile.id,
                            ),
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
                      itemCount: controller.businessProfiles.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final profile = controller.businessProfiles[index];
                        return Obx(
                          () => RecommendedVenue(
                            image: profile.gallery.isNotEmpty
                                ? profile.gallery.first.url
                                : 'https://via.placeholder.com/300',
                            title: profile.title,
                            description: profile.description,
                            location: profile.location,
                            isFavorite: controller.isFavoriteBusiness(
                              profile.id,
                            ),
                            onFavoriteTap: () {
                              controller.toggleFavoriteBusiness(profile.id);
                            },
                            profileId: profile.id,
                          ),
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

  List<BusinessProfile> _getFilteredProfiles(
    HomeController controller,
    int selectedTabIndex,
  ) {
    if (selectedTabIndex == -1) {
      // Show all profiles
      return controller.businessProfiles;
    } else if (selectedTabIndex < controller.categories.length) {
      // Filter by selected category
      final selectedCategoryId = controller.categories[selectedTabIndex].id;
      return controller.businessProfiles
          .where((profile) => profile.categoryId == selectedCategoryId)
          .toList();
    }
    return controller.businessProfiles;
  }
}
