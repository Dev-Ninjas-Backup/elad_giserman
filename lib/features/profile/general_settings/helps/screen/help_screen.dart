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
          CustomAppBar(
            lable: 'help_screen_title'.tr,
            back: '/generalSettingsScreen',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'faq_heading'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFAQTile(
                    index: 0,
                    controller: controller,
                    question: 'faq_q_reset_password'.tr,
                    answer: 'faq_a_reset_password'.tr,
                  ),
                  const SizedBox(height: 8),
                  _buildFAQTile(
                    index: 1,
                    controller: controller,
                    question: 'faq_q_update_profile'.tr,
                    answer: 'faq_a_update_profile'.tr,
                  ),
                  const SizedBox(height: 8),
                  _buildFAQTile(
                    index: 2,
                    controller: controller,
                    question: 'faq_q_app_crash'.tr,
                    answer: 'faq_a_app_crash'.tr,
                  ),
                  const SizedBox(height: 8),
                  _buildFAQTile(
                    index: 3,
                    controller: controller,
                    question: 'faq_q_delete_account'.tr,
                    answer: 'faq_a_delete_account'.tr,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'contact_us_heading'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'contact_us_paragraph'.tr,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: AppColors.buttonColor,
                    ),
                    title: Text(
                      'contact_email'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: AppColors.buttonColor,
                    ),
                    title: Text(
                      'contact_phone'.tr,
                      style: const TextStyle(fontSize: 16),
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
