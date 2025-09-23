import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/home/details/controller/details_controller.dart';
import 'package:elad_giserman/features/home/reservation/screen/reservation_screen.dart';
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
    final DetailsController detailsController = Get.put(DetailsController());
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
                CustomAppBar(lable: 'details_title'.tr, back: '/navBarScreen'),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 20, 18, 30),
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
                        '${rating.toString()} (${'reviews'.trParams({'count': reviewNum.toString()})})',
                        style: getTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.fontColor,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite, color: Colors.grey),
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
                    label: 'reserve_seats'.tr,
                    onPressed: () {
                      Get.to(
                        () => ReservationScreen(image: image),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    color: AppColors.buttonColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 24),
                  Divider(),
                  SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(14),
                    child: Row(
                      children: [
                        Image.asset(
                          ImagePath.profileImage,
                          height: 45,
                          width: 45,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ashfak Sayem',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryFontColor,
                              ),
                            ),
                            Text(
                              'Organizer',
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'about_restaurant'.tr,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => Text(
                      "At Olive & Thyme Mediterranean Kitchen, we believe dining is more than just eating-it’s an experience that brings people together. Nestled in the heart of Tel Aviv, our restaurant in the town and it's very beautiful.",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.fontColor,
                      ),
                      maxLines: detailsController.isExpanded.value ? null : 4,
                      overflow: detailsController.isExpanded.value
                          ? null
                          : TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => detailsController.toggleText(),
                    child: Obx(
                      () => Text(
                        detailsController.isExpanded.value
                            ? 'see_less'.tr
                            : 'read_more'.tr,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'facilities'.tr,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check, color: AppColors.buttonColor),
                              SizedBox(width: 5),
                              Text(
                                'Snack bar',
                                style: getTextStyle(
                                  fontSize: 14,
                                  color: AppColors.fontColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7),
                          Row(
                            children: [
                              Icon(Icons.check, color: AppColors.buttonColor),
                              SizedBox(width: 5),
                              Text(
                                'Bikes and Car Parking',
                                style: getTextStyle(
                                  fontSize: 14,
                                  color: AppColors.fontColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check, color: AppColors.buttonColor),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'Toilet',
                                    style: getTextStyle(
                                      fontSize: 14,
                                      color: AppColors.fontColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Icon(Icons.check, color: AppColors.buttonColor),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    '24/7 Water facility',
                                    style: getTextStyle(
                                      fontSize: 14,
                                      color: AppColors.fontColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Divider(),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        'rating_label'.tr,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(width: 5),
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
                        '${rating.toString()} (${'reviews'.trParams({'count': reviewNum.toString()})})',
                        style: getTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    maxLines: null,
                    minLines: 3,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFFD2D2D2),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFFD2D2D2),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFFD2D2D2),
                          width: 1,
                        ),
                      ),
                      hintText: 'add_a_comment'.tr,
                    ),
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomSmallButton(
                    text: 'add_comments_btn'.tr,
                    onPressed: () {},
                    buttonColor: AppColors.buttonColor,
                    fontColor: Colors.white,
                    width: 130,
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(IconPath.man, height: 24, width: 24),
                      SizedBox(width: 5),
                      Text(
                        'Sarah L.',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'hours_ago'.trParams({'count': '1'}),
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Had an amazing time at Karaoke Night! The atmosphere was vibrant, and the staff was super friendly. A perfect night out with friends. Highly recommend the cocktails too!",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fontColor,
                    ),
                    maxLines: detailsController.isExpanded.value ? null : 4,
                    overflow: detailsController.isExpanded.value
                        ? null
                        : TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Color(0xFFD2D2D2)),
                    ),
                    child: Text(
                      'reply'.tr,
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.fontColor,
                      ),
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
