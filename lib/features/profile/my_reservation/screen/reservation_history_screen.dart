import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/details/screen/details_screen.dart';
import 'package:elad_giserman/features/profile/my_reservation/controller/user_reservation_controller.dart';
import 'package:elad_giserman/features/profile/my_reservation/model/reservation_model.dart';
import 'package:elad_giserman/features/profile/my_reservation/widget/reservation_widget.dart';
import 'package:elad_giserman/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationHistoryScreen extends StatefulWidget {
  final bool isFromBottomNav;

  const ReservationHistoryScreen({super.key, this.isFromBottomNav = true});

  @override
  State<ReservationHistoryScreen> createState() =>
      _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh data when screen is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshReservations();
    });
  }

  void _refreshReservations() {
    final controller = Get.find<UserReservationController>();
    if (controller.isLoggedIn.value) {
      controller.fetchReservations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserReservationController>(
      init: UserReservationController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(
                  lable: 'reservation_history_title'.tr,
                  showBackButton: !widget.isFromBottomNav,
                  back: '/navBarScreen',
                ),
                Obx(() {
                  // Show login card if not logged in
                  if (!controller.isLoggedIn.value) {
                    return _buildLoginCard();
                  }

                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      ),
                    );
                  }

                  if (controller.errorMessage.value.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 24,
                      ),
                      child: Center(
                        child: Text(
                          controller.errorMessage.value,
                          style: getTextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    );
                  }

                  if (!controller.hasReservations) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 24,
                      ),
                      child: Center(
                        child: Text(
                          'No reservations yet',
                          style: getTextStyle(
                            fontSize: 16,
                            color: AppColors.fontColor,
                          ),
                        ),
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // This Week Section
                        if (controller.thisWeekReservations.isNotEmpty) ...[
                          Text(
                            'this_week'.tr,
                            style: getTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          ..._buildReservationList(
                            controller.thisWeekReservations,
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                        ],

                        // Last Week Section
                        if (controller.lastWeekReservations.isNotEmpty) ...[
                          Text(
                            'last_week'.tr,
                            style: getTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          ..._buildReservationList(
                            controller.lastWeekReservations,
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 48,
                  color: AppColors.buttonColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'login_required'.tr,
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryFontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'login_description'.tr,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.fontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offNamed(AppRoute.getSignInScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'sign_in'.tr,
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildReservationList(List<Reservation> reservations) {
    return reservations.asMap().entries.expand((entry) {
      final isLast = entry.key == reservations.length - 1;
      return [
        ReservationWidget(
          image: entry.value.restaurant.gallery.isNotEmpty
              ? entry.value.restaurant.gallery.first
              : null,
          category: 'category_restaurant'.tr,
          name: entry.value.restaurant.title,
          date: entry.value.date,
          time: entry.value.time,
          onPressed: () {
            Get.to(
              DetailsScreen(
                profileId: entry.value.restaurantId,
                isFromReservationHistory: true,
              ),
            );
          },
          onDelete: () {
            _showDeleteConfirmation(entry.value.id);
          },
        ),
        if (!isLast) SizedBox(height: 12),
      ];
    }).toList();
  }

  void _showDeleteConfirmation(String reservationId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text(
          'Are you sure you want to delete this reservation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(Get.context!),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(Get.context!); // Close dialog first
              final controller = Get.find<UserReservationController>();
              final success = await controller.deleteReservation(reservationId);

              if (success) {
                // UI will auto-update because deleteReservation calls fetchReservations()
                // which updates reservationResponse.value triggering Obx rebuild
                Get.snackbar(
                  'Success',
                  'Reservation deleted successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Failed to delete reservation',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
