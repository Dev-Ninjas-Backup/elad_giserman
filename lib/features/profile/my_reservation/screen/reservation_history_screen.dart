import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/profile/my_reservation/screen/reservation_details.dart';
import 'package:elad_giserman/features/profile/my_reservation/widget/reservation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class ReservationHistoryScreen extends StatelessWidget {
  const ReservationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(
              lable: 'reservation_history_title'.tr,
              back: '/navBarScreen',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'today'.tr,
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  ReservationWidget(
                    image: ImagePath.recommended1,
                    category: 'category_restaurant'.tr,
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {
                      Get.to(
                        ReservationDetails(
                          image: ImagePath.recommended1,
                          title: 'Olive & Thyme Mediterranean Kitchen',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  ReservationWidget(
                    image: ImagePath.recommended1,
                    category: 'category_restaurant'.tr,
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {
                      Get.to(
                        ReservationDetails(
                          image: ImagePath.recommended2,
                          title: 'Olive & Thyme Mediterranean Kitchen',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'last_week'.tr,
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  ReservationWidget(
                    image: ImagePath.restaurant2,
                    category: 'category_cafe'.tr,
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {
                      Get.to(
                        ReservationDetails(
                          image: ImagePath.restaurant1,
                          title: 'Olive & Thyme Mediterranean Kitchen',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  ReservationWidget(
                    image: ImagePath.restaurant2,
                    category: 'category_bar'.tr,
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {
                      Get.to(
                        ReservationDetails(
                          image: ImagePath.recommended2,
                          title: 'Olive & Thyme Mediterranean Kitchen',
                        ),
                      );
                    },
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
