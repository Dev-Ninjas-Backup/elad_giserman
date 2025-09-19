import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/profile/widgets/vip_features.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(lable: 'Subscriptions', back: '/navBarScreen'),
            Container(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VipFeatures(),
                  SizedBox(height: 16),
                  Text(
                    'Subscription Pricing',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '\$14.99',
                          style: getTextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonColor,
                          ),
                          children: [
                            TextSpan(
                              text: '/month',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Monthly',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 20,
                          width: 32,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(95),
                          ),
                          child: Stack(
                            children: [
                              AnimatedAlign(
                                alignment: Alignment.centerRight,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(95),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Annually',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'VIP Benefits Banner',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Access to exclusive events & premium content',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Priority customer support',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Special member-only discounts & offers',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Early access to new features/services',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  CustomButton(
                    label: 'Pay with Stripe',
                    onPressed: () {
                      Get.offNamed('/checkoutScreen');
                    },
                    color: AppColors.buttonColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
