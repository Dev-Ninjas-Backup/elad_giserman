import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/profile/edit_profile/screen/edit_profile_screen.dart';
import 'package:elad_giserman/features/profile/main/widgets/log_out_button.dart';
import 'package:elad_giserman/features/profile/main/widgets/login_card.dart';
import 'package:elad_giserman/features/profile/main/widgets/option_button.dart';
import 'package:elad_giserman/features/profile/main/widgets/vip_features.dart';
import 'package:elad_giserman/features/profile/my_reservation/screen/reservation_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../../../../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller if not already present
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    controller = Get.find<ProfileController>();

    // Refresh profile data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadProfile(showLoading: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Show loading only on initial load
        if (controller.isLoading.value && controller.isInitialLoad.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.profile.value;

        return SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(lable: 'profile_title'.tr, showBackButton: false),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show login card if user is not logged in
                    if (user == null) ...[
                      const LoginCard(),
                      const SizedBox(height: 24),
                    ] else ...[
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
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name.isNotEmpty
                                    ? user.name
                                    : 'unnamed_user'.tr,
                                style: getTextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryFontColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email.length > 27
                                    ? '${user.email.substring(0, 27)}...'
                                    : user.email,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.fontColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${'username'.tr}: ${user.username}',
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
                          Get.to(EditProfileScreen());
                        },
                      ),
                      const SizedBox(height: 8),

                      OptionButton(
                        title: 'my_reservation'.tr,
                        button: () {
                          Get.to(
                            ReservationHistoryScreen(isFromBottomNav: false),
                          );
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
                        title: 'offers'.tr,
                        button: () {
                          Get.offNamed(AppRoute.getOffersScreen());
                        },
                      ),
                      // const SizedBox(height: 8),

                      // OptionButton(
                      //   title: 'subscriptions'.tr,
                      //   button: () {
                      //     Get.offNamed('/subscriptionScreen');
                      //   },
                      // ),
                      const SizedBox(height: 8),

                      OptionButton(
                        title: 'update_password'.tr,
                        button: () {
                          Get.offNamed('/updatePasswordScreen');
                        },
                      ),
                      const SizedBox(height: 8),
                    ],

                    OptionButton(
                      title: 'general_settings'.tr,
                      button: () {
                        Get.offNamed('/generalSettingsScreen');
                      },
                    ),
                    const SizedBox(height: 8),

                    if (user != null) LogOutButton(),
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
