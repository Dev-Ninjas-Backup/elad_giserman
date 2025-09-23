import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedTab extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final String category;
  final double rating;
  final int reviewNum;
  const RecommendedTab({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.category,
    required this.rating,
    required this.reviewNum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 1, color: AppColors.borderColor),
        color: Colors.white,
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
                child: Image.asset(
                  image,
                  height: 130,
                  width: Get.width,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white38,
                      ),
                      child: Text(
                        {
                              'Restaurant': 'category_restaurant'.tr,
                              'Cafe': 'category_cafe'.tr,
                              'Bar': 'category_bar'.tr,
                            }[category] ??
                            category,
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                // In RTL languages (like Hebrew) show reviews before rating for natural reading order
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
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryFontColor,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(IconPath.activeHistory, height: 18, width: 18),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        location,
                        style: getTextStyle(
                          color: AppColors.fontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                CustomSmallButton(
                  text: 'reserve_seat'.tr,
                  onPressed: () {},
                  buttonColor: AppColors.buttonColor,
                  fontColor: Colors.white,
                  width: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
