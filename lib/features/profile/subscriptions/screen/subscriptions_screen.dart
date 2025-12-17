import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/profile/main/widgets/vip_features.dart';
import 'package:elad_giserman/features/profile/subscriptions/controller/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.buttonColor,
              ),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            );
          }

          final currentPlan = controller.currentPlan;

          return SingleChildScrollView(
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
                          if (currentPlan != null)
                            Text.rich(
                              TextSpan(
                                text: currentPlan.formattedPrice,
                                style: getTextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: controller.isMonthlySelected.value
                                        ? '/month'
                                        : '/year',
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
                            onTap: () {
                              controller.toggleBillingPeriod(
                                !controller.isMonthlySelected.value,
                              );
                            },
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
                                    alignment: controller.isMonthlySelected.value
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(95),
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
                      if (currentPlan != null && currentPlan.discountPercent > 0)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Save ${currentPlan.discountPercent}%',
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
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
                      if (currentPlan != null)
                        ...currentPlan.benefits.map((benefit) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.buttonColor,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      benefit,
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
                            ],
                          );
                        }),
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
                        onPressed: () {
                          // TODO: Implement Stripe payment
                        },
                        color: AppColors.buttonColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
