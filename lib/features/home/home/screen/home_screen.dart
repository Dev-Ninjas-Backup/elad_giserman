import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/home/widgets/home_app_bar.dart';
import 'package:elad_giserman/features/home/home/widgets/popular_near_widget.dart';
import 'package:elad_giserman/features/home/home/widgets/recommended_venue.dart';
import 'package:elad_giserman/features/home/home/widgets/vip_features_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'popular_near_you'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'see_all'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => SizedBox(
                      height: 320,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.restaurants.length,
                        separatorBuilder: (_, __) => SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          final item = controller.restaurants[index];
                          return PopularNearWidget(
                            image: item.image,
                            title: item.title,
                            subTitle: item.subTitle,
                            rating: item.rating,
                            reviewNum: item.reviewNum,
                            category: item.category,
                            isFavorite: item.isFavorite,
                            onFavoriteTap: () =>
                                controller.toggleFavorite(index),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  VipFeaturesWidget(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'recommended_venues'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Get.offNamed('/venueScreen'),
                        child: Text(
                          'see_all'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.fontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Obx(
                    () => ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.recommended.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
