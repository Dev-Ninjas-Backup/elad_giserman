import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipFeaturesWidget extends StatelessWidget {
  final String? bannerCard;
  final String? bannerPhoto;
  final String? title;
  final String? description;

  const VipFeaturesWidget({
    super.key,
    this.bannerCard,
    this.bannerPhoto,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final displayTitle = title ?? 'vip_title'.tr;
    final displayDescription = description ?? 'vip_description'.tr;
    final displayBannerCard =
        bannerCard ?? 'https://via.placeholder.com/400x200';
    final displayBannerPhoto = bannerPhoto ?? ImagePath.strawGlass;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: _buildBackgroundImage(displayBannerCard),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayTitle,
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  displayDescription,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(height: 30),
                  // CustomSmallButton(
                  //   width: 130,
                  //   text: 'go_premium'.tr,
                  //   onPressed: () {
                  //     Get.toNamed('/subscriptionScreen');
                  //   },
                  //   buttonColor: Colors.white,
                  //   fontColor: Colors.black,
                  // ),
                ),
              ],
            ),
          ),
          _buildBannerPhoto(displayBannerPhoto),
        ],
      ),
    );
  }

  DecorationImage? _buildBackgroundImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover);
    }
    return null;
  }

  Widget _buildBannerPhoto(String imagePath) {
    // Check if it's a URL (starts with http) or a local asset
    if (imagePath.startsWith('http')) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(ImagePath.strawGlass, scale: 4);
            },
          ),
        ),
      );
    } else {
      return Image.asset(imagePath, scale: 4);
    }
  }
}
