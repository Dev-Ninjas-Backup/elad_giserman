import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/features/notifications/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/colors.dart';
import '../widget/notification_item_widget.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: Column(
        children: [
          CustomAppBar(lable: 'notifications'.tr),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              final notificationData = controller.notificationData.value;
              if (notificationData == null) {
                return Center(child: Text('No notifications'));
              }

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Today section
                    if (notificationData.today.isNotEmpty) ...[
                      Text(
                        'today'.tr,
                        style: TextStyle(
                          color: AppColors.primaryFontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      ...notificationData.today.map((item) {
                        final timeAgo = _getTimeAgo(item.createdAt);
                        return NotificationItemWidget(
                          title: item.notification.title,
                          body: item.notification.message,
                          timeAgo: timeAgo,
                          highlighted: !item.read,
                        );
                      }).toList(),
                    ],

                    // Divider between sections
                    if (notificationData.today.isNotEmpty &&
                        notificationData.previous.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Divider(color: AppColors.borderColor, thickness: 0.5),
                      SizedBox(height: 20),
                    ],

                    // Previous section
                    if (notificationData.previous.isNotEmpty) ...[
                      Text(
                        'previous'.tr,
                        style: TextStyle(
                          color: AppColors.primaryFontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      ...notificationData.previous.map((item) {
                        final timeAgo = _getTimeAgo(item.createdAt);
                        return NotificationItemWidget(
                          title: item.notification.title,
                          body: item.notification.message,
                          timeAgo: timeAgo,
                          highlighted: !item.read,
                        );
                      }).toList(),
                    ],

                    // Empty state
                    if (notificationData.today.isEmpty &&
                        notificationData.previous.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            'no_notifications'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.fontColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(String dateString) {
    try {
      final createdDate = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(createdDate);

      if (difference.inMinutes < 1) {
        return 'just_now'.tr;
      } else if (difference.inMinutes < 60) {
        return 'minutes_ago'.trParams({
          'count': difference.inMinutes.toString(),
        });
      } else if (difference.inHours < 24) {
        return 'hours_ago'.trParams({'count': difference.inHours.toString()});
      } else if (difference.inDays < 7) {
        return 'days_ago'.trParams({'count': difference.inDays.toString()});
      } else {
        return dateString.split('T')[0]; // Return date in YYYY-MM-DD format
      }
    } catch (e) {
      return dateString;
    }
  }
}
