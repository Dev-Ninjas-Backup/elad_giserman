import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final String image;
  final double rating;
  final int reviewNum;
  const DetailsScreen({
    super.key,
    required this.image,
    required this.rating,
    required this.reviewNum,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 58),
                  child: Image.asset(
                    image,
                    height: 248,
                    width: Get.width,
                    fit: BoxFit.fill,
                  ),
                ),
                CustomAppBar(lable: 'Details', back: '/navBarScreen'),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              height: Get.height,
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.deepOrangeAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.deepOrangeAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.deepOrangeAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.deepOrangeAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.deepOrangeAccent,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '$rating ($reviewNum reviews)',
                        style: getTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                  Text(
                    title,
                    style: getTextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Image.asset(
                        IconPath.activeHistory,
                        height: 18,
                        width: 18,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        location,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.alarm, color: AppColors.buttonColor, size: 18),
                      SizedBox(width: 5),
                      Text(
                        '11:00 AM - 10:00 PM',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    label: 'Reserve Seats',
                    onPressed: () {},
                    color: AppColors.buttonColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 24),
                  Divider(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
