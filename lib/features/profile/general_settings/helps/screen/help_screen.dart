import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/profile/general_settings/helps/controller/help_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HelpController controller = Get.put(HelpController());

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(lable: 'Help & Support', back: '/generalSettingsScreen'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildFAQTile(
                    index: 0,
                    controller: controller,
                    question: 'How do I reset my password?',
                    answer:
                        'To reset your password, go to the login screen, tap "Forgot Password," and follow the instructions to receive a reset link via email.',
                  ),
                  SizedBox(height: 8),
                  _buildFAQTile(
                    index: 1,
                    controller: controller,
                    question: 'How can I update my profile?',
                    answer:
                        'Navigate to the Profile section in the app settings, tap "Edit Profile," and update your information as needed.',
                  ),
                  SizedBox(height: 8),
                  _buildFAQTile(
                    index: 2,
                    controller: controller,
                    question: 'What should I do if the app crashes?',
                    answer:
                        'Ensure you have the latest app version. If the issue persists, contact support with details about the crash.',
                  ),
                  SizedBox(height: 8),
                  _buildFAQTile(
                    index: 3,
                    controller: controller,
                    question: 'How do I delete my account?',
                    answer:
                        'Go to Settings, select "Account Management," and choose "Delete Account." Follow the prompts to confirm.',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'For further assistance, reach out to us at:',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.email, color: AppColors.buttonColor),
                    title: const Text(
                      'support@example.com',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: AppColors.buttonColor,
                    ),
                    title: const Text(
                      '+1-800-123-4567',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQTile({
    required int index,
    required HelpController controller,
    required String question,
    required String answer,
  }) {
    return Obx(
      () => ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.buttonColor,
          ),
        ),
        onExpansionChanged: (expanded) {
          if (expanded) {
            controller.toggleTile(index);
          } else if (controller.expandedTile.value == index) {
            controller.toggleTile(index);
          }
        },
        initiallyExpanded: controller.expandedTile.value == index,
        backgroundColor: Colors.grey.shade100,
        collapsedBackgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
