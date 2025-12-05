import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/profile/main/widgets/vip_features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(lable: 'subscriptions'.tr, showBackButton: false),
            Container(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VipFeatures(),
                  SizedBox(height: 16),
                  Text(
                    'subscription_pricing'.tr,
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
                          text: 'monthly_price'.tr,
                          style: getTextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'per_month'.tr,
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
                        'monthly'.tr,
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
                        'annually'.tr,
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
                    'vip_benefits_banner'.tr,
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
                          'benefit_exclusive_events'.tr,
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
                          'benefit_priority_support'.tr,
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
                          'benefit_discounts'.tr,
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
                          'benefit_early_access'.tr,
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
                  Container(
                    height: 48,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.textFieldFillColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        IconPath.stripe,
                        height: 25,
                        width: 63,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  CustomButton(
                    label: 'pay_with_stripe'.tr,
                    onPressed: () {},
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
