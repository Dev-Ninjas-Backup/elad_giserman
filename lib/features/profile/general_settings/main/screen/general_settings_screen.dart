import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/general_settings_controller.dart';
import '../widget/setting_tile_widget.dart';
import '../../../../../core/utils/constants/colors.dart';

class GeneralSettingsScreen extends StatelessWidget {
  final GeneralSettingsController controller = Get.put(
    GeneralSettingsController(),
  );

  GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppBar(lable: 'general_setting'.tr, back: '/navBarScreen'),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'apps_language'.tr,
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _showLanguagePicker(context),
                    child: Container(
                      width: double.infinity,
                      height: 46,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldFillColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              controller.getDisplayLanguage(),
                              style: TextStyle(
                                color: AppColors.primaryFontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.fontColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'notification_setting'.tr,
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Obx(
                        () => Switch(
                          value: controller.notificationsEnabled.value,
                          activeThumbColor: AppColors.buttonColor,
                          onChanged: (v) => controller.toggleNotifications(v),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'allow_push_notifications'.tr,
                        style: TextStyle(
                          color: AppColors.primaryFontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Divider(color: AppColors.borderColor, thickness: 1),
                  SizedBox(height: 16),

                  SettingTileWidget(
                    title: 'about_evnc'.tr,
                    trailing: Row(
                      children: [
                        Text(
                          'version'.tr,
                          style: TextStyle(color: AppColors.fontColor),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.fontColor,
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.offNamed('/aboutScreen');
                    },
                  ),
                  SizedBox(height: 12),
                  SettingTileWidget(
                    title: 'helps'.tr,
                    onTap: () {
                      Get.offNamed('/helpScreen');
                    },
                  ),
                  SizedBox(height: 12),
                  SettingTileWidget(
                    title: 'term_of_use'.tr,
                    onTap: () {
                      Get.offNamed('termOfUseScreen');
                    },
                  ),
                  SizedBox(height: 12),
                  SettingTileWidget(
                    title: 'privacy_policy'.tr,
                    onTap: () {
                      Get.offNamed('/privacyPolicyScreen');
                    },
                  ),

                  SizedBox(height: 16),
                  Divider(color: AppColors.borderColor, thickness: 1),
                  SizedBox(height: 16),

                  SettingTileWidget(
                    title: 'delete_account'.tr,
                    titleColor: Color(0xFFE54400),
                    onTap: () {
                      controller.showDeleteAccountConfirmation();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'language_selection'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryFontColor,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('English'),
                onTap: () {
                  controller.setLanguage('english');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Hebrew'),
                onTap: () {
                  controller.setLanguage('hebrew');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
