import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedVenue extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String location;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  const RecommendedVenue({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.location,
    required this.isFavorite,
    required this.onFavoriteTap,
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
                  height: 150,
                  width: Get.width,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  behavior: HitTestBehavior.translucent,
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(16),
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
                SizedBox(height: 8),
                Text(
                  description,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.fontColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                CustomSmallButton(
                  text: 'view_details'.tr,
                  onPressed: () {},
                  buttonColor: AppColors.buttonColor,
                  fontColor: Colors.white,
                  width: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
