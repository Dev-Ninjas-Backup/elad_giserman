import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/home/controller/home_controller.dart';
import 'package:elad_giserman/features/home/home/widgets/recommended_venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueScreen extends StatelessWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(lable: 'venues_title'.tr, back: '/navBarScreen'),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 0),
              child: Text(
                'popular_near_you'.tr,
                style: getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryFontColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Obx(
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
            ),
          ],
        ),
      ),
    );
  }
}
