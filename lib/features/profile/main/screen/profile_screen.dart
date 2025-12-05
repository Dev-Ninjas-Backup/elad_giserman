import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:elad_giserman/features/profile/main/widgets/log_out_button.dart';
import 'package:elad_giserman/features/profile/main/widgets/option_button.dart';
import 'package:elad_giserman/features/profile/main/widgets/vip_features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../../../../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reload profile data when app is resumed/screen comes back to focus
      controller.loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.profile.value;

        if (user == null) {
          return const Center(
            child: Text(
              "Failed to load profile",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(lable: 'profile_title'.tr, back: ''),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 34,
                          backgroundImage: NetworkImage(
                            user.avatarUrl.isNotEmpty
                                ? user.avatarUrl
                                : ImagePath.profileImage2,
                          ),
                          onBackgroundImageError: (exception, stackTrace) {
                            // Fallback image
                          },
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: getTextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryFontColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.email,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Username: ${user.username}",
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

                    const SizedBox(height: 16),
                    VipFeatures(),
                    const SizedBox(height: 16),

                    OptionButton(
                      title: 'edit_profile'.tr,
                      button: () {
                        Get.to(
                          const EditProfileScreen(),
                        );
                      },
                    ),
                    const SizedBox(height: 8),

                    OptionButton(
                      title: 'my_reservation'.tr,
                      button: () {
                        Get.offNamed('/reservationScreen');
                      },
                    ),
                    const SizedBox(height: 8),

                    OptionButton(
                      title: 'redemption_history'.tr,
                      button: () {
                        Get.offNamed(AppRoute.getRedemptionHistoryScreen());
                      },
                    ),
                    const SizedBox(height: 8),

                    OptionButton(
                      title: 'subscriptions'.tr,
                      button: () {
                        Get.offNamed('/subscriptionScreen');
                      },
                    ),
                    const SizedBox(height: 8),

                    OptionButton(
                      title: 'update_password'.tr,
                      button: () {
                        Get.offNamed('/updatePasswordScreen');
                      },
                    ),
                    const SizedBox(height: 8),

                    OptionButton(
                      title: 'general_settings'.tr,
                      button: () {
                        Get.offNamed('/generalSettingsScreen');
                      },
                    ),
                    const SizedBox(height: 8),

                    LogOutButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
