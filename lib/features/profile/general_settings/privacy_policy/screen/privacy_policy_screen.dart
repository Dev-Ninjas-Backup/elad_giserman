import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/profile/general_settings/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrivacyPolicyController controller = Get.put(
      PrivacyPolicyController(),
    );

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            lable: 'privacy_policy'.tr,
            back: '/generalSettingsScreen',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'privacy_1_heading'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'privacy_1_content'.tr,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'privacy_2_heading'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'privacy_2_content'.tr,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'privacy_3_heading'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'privacy_3_content'.tr,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'privacy_4_heading'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'privacy_4_content'.tr,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'privacy_5_heading'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'privacy_5_content'.tr,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.acceptPolicy(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'accept_terms'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
