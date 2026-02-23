// ignore_for_file: unused_element

//import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
// import 'package:elad_giserman/core/common/widgets/custom_button.dart';
// import 'package:elad_giserman/core/utils/constants/colors.dart';
// import 'package:elad_giserman/core/utils/constants/icon_path.dart';
// import 'package:elad_giserman/features/profile/main/widgets/vip_features.dart';
// import 'package:elad_giserman/features/profile/subscriptions/controller/subscription_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  Future<void> _openStripePayment() async {
    const stripePaymentUrl = 'https://yamiz.org/auth-login';

    try {
      final Uri uri = Uri.parse(stripePaymentUrl);

      if (kDebugMode) {
        print('🔄 Attempting to open payment URL: $stripePaymentUrl');
      }

      try {
        final bool canLaunch = await canLaunchUrl(uri);
        if (kDebugMode) {
          print('   canLaunchUrl result: $canLaunch');
        }

        if (canLaunch) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (kDebugMode) {
            print('✅ Stripe payment URL opened successfully');
          }
        } else {
          if (kDebugMode) {
            print('⚠️ Cannot launch URL, trying direct launch...');
          }
          // Fallback: try to launch without checking
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (kDebugMode) {
            print('✅ Stripe payment URL opened with fallback');
          }
        }
      } on Exception catch (e) {
        if (kDebugMode) {
          print('⚠️ canLaunchUrl threw exception: $e');
          print('   Attempting direct launch as fallback...');
        }
        // Fallback: Direct launch
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (kDebugMode) {
            print('✅ Stripe payment URL opened with direct launch');
          }
        } catch (launchError) {
          if (kDebugMode) {
            print('❌ Direct launch also failed: $launchError');
          }
          _showErrorSnackbar('Could not open payment page. Please try again.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error opening Stripe payment URL: $e');
      }
      _showErrorSnackbar('An error occurred while opening the payment page.');
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  final controller = Get.put(SubscriptionController());

    return Scaffold(
      body:
          // Obx(() {
          //   if (controller.isLoading.value) {
          //     return Center(
          //       child: CircularProgressIndicator(color: AppColors.buttonColor),
          //     );
          //   }
          //   if (controller.errorMessage.value.isNotEmpty) {
          //     return Center(
          //       child: Text(
          //         controller.errorMessage.value,
          //         style: getTextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.red,
          //         ),
          //       ),
          //     );
          //   }
          //   final currentPlan = controller.currentPlan;
          //   return SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         CustomAppBar(lable: 'subscriptions'.tr, showBackButton: false),
          //         Container(
          //           padding: EdgeInsets.all(18),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               VipFeatures(),
          //               SizedBox(height: 16),
          //               Text(
          //                 'subscription_pricing'.tr,
          //                 style: getTextStyle(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w400,
          //                   color: AppColors.primaryFontColor,
          //                 ),
          //               ),
          //               SizedBox(height: 4),
          //               Row(
          //                 children: [
          //                   if (currentPlan != null)
          //                     Text.rich(
          //                       TextSpan(
          //                         text: controller.isMonthlySelected.value
          //                             ? currentPlan.formattedPrice
          //                             : currentPlan.formattedYearlyPrice,
          //                         style: getTextStyle(
          //                           fontSize: 22,
          //                           fontWeight: FontWeight.w600,
          //                           color: AppColors.buttonColor,
          //                         ),
          //                         children: [
          //                           TextSpan(
          //                             text: controller.isMonthlySelected.value
          //                                 ? '/month'
          //                                 : '/year',
          //                             style: getTextStyle(
          //                               fontSize: 14,
          //                               fontWeight: FontWeight.w400,
          //                               color: AppColors.buttonColor,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   Spacer(),
          //                   Text(
          //                     'monthly'.tr,
          //                     style: getTextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w400,
          //                       color: AppColors.primaryFontColor,
          //                     ),
          //                   ),
          //                   SizedBox(width: 4),
          //                   GestureDetector(
          //                     onTap: () {
          //                       controller.toggleBillingPeriod(
          //                         !controller.isMonthlySelected.value,
          //                       );
          //                     },
          //                     child: Container(
          //                       height: 20,
          //                       width: 32,
          //                       decoration: BoxDecoration(
          //                         color: Colors.black,
          //                         borderRadius: BorderRadius.circular(95),
          //                       ),
          //                       child: Stack(
          //                         children: [
          //                           AnimatedAlign(
          //                             alignment: controller.isMonthlySelected.value
          //                                 ? Alignment.centerLeft
          //                                 : Alignment.centerRight,
          //                             duration: Duration(milliseconds: 200),
          //                             curve: Curves.easeInOut,
          //                             child: Container(
          //                               margin: EdgeInsets.all(2),
          //                               width: 16,
          //                               height: 16,
          //                               decoration: BoxDecoration(
          //                                 color: Colors.white,
          //                                 borderRadius: BorderRadius.circular(95),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(width: 4),
          //                   Text(
          //                     'annually'.tr,
          //                     style: getTextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w400,
          //                       color: AppColors.primaryFontColor,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               if (currentPlan != null && currentPlan.discountPercent > 0)
          //                 Padding(
          //                   padding: EdgeInsets.only(top: 8),
          //                   child: Text(
          //                     'Save ${currentPlan.discountPercent}%',
          //                     style: getTextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w600,
          //                       color: Colors.green,
          //                     ),
          //                   ),
          //                 ),
          //               SizedBox(height: 16),
          //               Divider(),
          //               SizedBox(height: 16),
          //               Text(
          //                 'vip_benefits_banner'.tr,
          //                 style: getTextStyle(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w600,
          //                   color: AppColors.primaryFontColor,
          //                 ),
          //               ),
          //               SizedBox(height: 14),
          //               if (currentPlan != null)
          //                 ...currentPlan.benefits.map((benefit) {
          //                   return Column(
          //                     children: [
          //                       Row(
          //                         children: [
          //                           Icon(
          //                             Icons.check_circle_outline,
          //                             color: AppColors.buttonColor,
          //                           ),
          //                           SizedBox(width: 8),
          //                           Expanded(
          //                             child: Text(
          //                               benefit,
          //                               style: getTextStyle(
          //                                 fontSize: 14,
          //                                 fontWeight: FontWeight.w400,
          //                                 color: AppColors.primaryFontColor,
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       SizedBox(height: 14),
          //                     ],
          //                   );
          //                 }),
          //               SizedBox(height: 80),
          //               Container(
          //                 height: 48,
          //                 width: double.infinity,
          //                 padding: EdgeInsets.symmetric(horizontal: 16),
          //                 decoration: BoxDecoration(
          //                   color: AppColors.textFieldFillColor,
          //                   borderRadius: BorderRadius.circular(12),
          //                 ),
          //                 child: Align(
          //                   alignment: Alignment.centerLeft,
          //                   child: Image.asset(
          //                     IconPath.stripe,
          //                     height: 25,
          //                     width: 63,
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(height: 12),
          //               CustomButton(
          //                 label: 'pay_with_stripe'.tr,
          //                 onPressed: _openStripePayment,
          //                 color: AppColors.buttonColor,
          //                 textColor: Colors.white,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }),
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(lable: 'subscriptions'.tr, showBackButton: false),
            
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 350),
                    child: Text(
                      'secure_payment_coming_soon'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryFontColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
