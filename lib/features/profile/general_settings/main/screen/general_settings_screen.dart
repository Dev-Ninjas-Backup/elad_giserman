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
          CustomAppBar(lable: 'General Setting', back: '/navBarScreen'),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "App’s Language",
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
                              controller.language.value,
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
                    'Notification Setting',
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
                        'Allow Push Notifications',
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
                    title: 'About EVNC',
                    trailing: Row(
                      children: [
                        Text(
                          'Version 1.0.0.1',
                          style: TextStyle(color: AppColors.fontColor),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.fontColor,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 12),
                  SettingTileWidget(title: 'Helps', onTap: () {}),
                  SizedBox(height: 12),
                  SettingTileWidget(title: 'Term of Use', onTap: () {}),
                  SizedBox(height: 12),
                  SettingTileWidget(
                    title: 'Privacy Policy',
                    onTap: () {
                      Get.offNamed('/privacyPolicyScreen');
                    },
                  ),

                  SizedBox(height: 16),
                  Divider(color: AppColors.borderColor, thickness: 1),
                  SizedBox(height: 16),

                  SettingTileWidget(
                    title: 'Delete Account',
                    titleColor: Color(0xFFE54400),
                    onTap: () {},
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
              ListTile(
                title: Text('English'),
                onTap: () {
                  controller.setLanguage('English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Spanish'),
                onTap: () {
                  controller.setLanguage('Spanish');
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
