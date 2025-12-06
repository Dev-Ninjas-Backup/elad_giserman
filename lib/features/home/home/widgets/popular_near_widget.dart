import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/home/details/screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularNearWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final double rating;
  final int reviewNum;
  final String category;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final String profileId;

  const PopularNearWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.reviewNum,
    required this.rating,
    required this.image,
    required this.category,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 1, color: Color(0xFFEBEBEB)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: image.startsWith('http')
                    ? Image.network(
                        image,
                        height: 120,
                        width: Get.width,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120,
                            width: Get.width,
                            color: Colors.grey[300],
                            child: Icon(Icons.image_not_supported),
                          );
                        },
                      )
                    : Image.asset(
                        image,
                        height: 120,
                        width: Get.width,
                        fit: BoxFit.fill,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white38,
                      ),
                      child: Text(
                        '1 + 1',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: onFavoriteTap,
                      child: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                if (Get.locale?.languageCode == 'he') ...[
                  Text(
                    '${'reviews'.trParams({'count': reviewNum.toString()})} (${rating.toString()})',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fontColor,
                    ),
                  ),
                ] else ...[
                  Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                  Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                  Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                  Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                  Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                  SizedBox(width: 6),
                  Text(
                    '${rating.toString()} (${'reviews'.trParams({'count': reviewNum.toString()})})',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fontColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.primaryFontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 6,
              bottom: 12,
            ),
            child: Row(
              children: [
                Image.asset(IconPath.activeHistory, height: 18, width: 18),
                SizedBox(width: 3),
                Expanded(
                  child: Text(
                    subTitle,
                    style: getTextStyle(
                      color: AppColors.fontColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomSmallButton(
              text: 'view_details'.tr,
              onPressed: () {
                Get.to(() => DetailsScreen(profileId: profileId));
              },
              buttonColor: AppColors.buttonColor,
              fontColor: Colors.white,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
