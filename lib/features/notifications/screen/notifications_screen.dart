import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants/colors.dart';
import '../widget/notification_item_widget.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: Column(
        children: [
          CustomAppBar(lable: 'notifications'.tr),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'today'.tr,
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),

                  NotificationItemWidget(
                    title: 'Congratulations!',
                    body:
                        'Your table for 2 at La Bella Café is confirmed for 7:30 PM tonight',
                    timeAgo: 'minutes_ago'.trParams({'count': '5'}),
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    highlighted: true,
                  ),

                  NotificationItemWidget(
                    title: 'Reminder',
                    body:
                        'Dinner reservation at Spice Garden tomorrow at 8:00 PM',
                    timeAgo: 'hours_ago'.trParams({'count': '1'}),
                    icon: Icons.notifications_active_outlined,
                    iconColor: Colors.purple,
                    highlighted: false,
                  ),

                  NotificationItemWidget(
                    title: 'Special Offer',
                    body:
                        'Get a free dessert with your booking at Sweet Tooth Diner 🍨',
                    timeAgo: 'hours_ago'.trParams({'count': '1'}),
                    icon: Icons.local_offer,
                    iconColor: Colors.redAccent,
                    highlighted: false,
                  ),

                  SizedBox(height: 20),
                  Divider(color: AppColors.borderColor, thickness: 0.5),
                  SizedBox(height: 20),

                  Text(
                    'yesterday'.tr,
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),

                  NotificationItemWidget(
                    title: 'Special Offer',
                    body:
                        'Your VIP Subscription is expiring soon! Renew now to keep enjoying priority bookings, exclusive discounts & special offers.',
                    timeAgo: 'hours_ago'.trParams({'count': '1'}),
                    icon: Icons.local_offer,
                    iconColor: Colors.green,
                    highlighted: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
