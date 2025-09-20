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
          CustomAppBar(lable: 'Privacy Policy', back: '/generalSettingsScreen'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Introduction',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome to our app. We value your privacy and are committed to protecting your personal data. This Privacy Policy explains how we collect, use, and safeguard your information.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2. Information We Collect',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We may collect the following types of information:\n'
                    '- Personal Information: Name, email, etc.\n'
                    '- Usage Data: App interactions, device information, etc.\n'
                    '- Cookies: For improving user experience.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '3. How We Use Your Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your information is used to:\n'
                    '- Provide and improve our services.\n'
                    '- Personalize your experience.\n'
                    '- Ensure security and compliance.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '4. Sharing Your Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We do not share your personal information with third parties except as required by law or with your consent.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '5. Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'If you have any questions about this Privacy Policy, please contact us at support@example.com.',
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
                        'Accept',
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
