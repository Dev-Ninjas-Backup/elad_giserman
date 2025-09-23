import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/profile/main/widgets/log_out_button.dart';
import 'package:elad_giserman/features/profile/main/widgets/option_button.dart';
import 'package:elad_giserman/features/profile/main/widgets/vip_features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(lable: 'profile_title'.tr, back: ''),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ImagePath.profileImage2,
                        height: 68,
                        width: 68,
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            'Franklin Clinton',
                            style: getTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          Text(
                            'franklinclinton@gmail.com',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.fontColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  VipFeatures(),
                  SizedBox(height: 16),
                  OptionButton(
                    title: 'edit_profile'.tr,
                    button: () {
                      Get.offNamed('/editProfileScreen');
                    },
                  ),
                  SizedBox(height: 8),
                  OptionButton(
                    title: 'my_reservation'.tr,
                    button: () {
                      Get.offNamed('/reservationScreen');
                    },
                  ),
                  SizedBox(height: 8),
                  OptionButton(
                    title: 'redemption_history'.tr,
                    button: () {
                      Get.offNamed(AppRoute.getRedemptionHistoryScreen());
                    },
                  ),
                  SizedBox(height: 8),
                  OptionButton(
                    title: 'subscriptions'.tr,
                    button: () {
                      Get.offNamed('/subscriptionScreen');
                    },
                  ),
                  SizedBox(height: 8),
                  OptionButton(
                    title: 'update_password'.tr,
                    button: () {
                      Get.offNamed('/updatePasswordScreen');
                    },
                  ),
                  SizedBox(height: 8),
                  OptionButton(
                    title: 'general_settings'.tr,
                    button: () {
                      Get.offNamed('/generalSettingsScreen');
                    },
                  ),
                  SizedBox(height: 8),
                  LogOutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
