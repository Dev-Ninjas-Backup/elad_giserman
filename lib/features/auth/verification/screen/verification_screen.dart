import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:elad_giserman/features/auth/verification/controller/verification_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  final String verificationEmail;
  final String previousScreen;

  VerificationScreen({
    super.key,
    required this.verificationEmail,
    required this.previousScreen,
  });

  final VerificationController controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: AppColors().buildGradientBackground(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(lable: 'verification_title'.tr),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'verification_title'.tr,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'verification_sent'.trParams({
                        'email': verificationEmail,
                      }),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF636363),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.fromLTRB(27, 0, 27, 21),
                      child: OtpTextField(
                        numberOfFields: 4,
                        fieldWidth: 55,
                        fieldHeight: 55,
                        margin: EdgeInsets.only(right: 10),
                        textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        keyboardType: TextInputType.number,
                        showFieldAsBox: true,
                        borderRadius: BorderRadius.circular(12),
                        filled: true,
                        fillColor: Colors.white,
                        borderColor: Color(0xFFD2D2D2),
                        enabledBorderColor: Color(0xFFD2D2D2),
                        focusedBorderColor: Colors.black,
                        borderWidth: 1,
                        cursorColor: Colors.black,
                        onSubmit: (code) {
                          controller.otpCode = code;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: 'verify_btn'.tr,
                      onPressed: () async {
                        final isVerified = await controller.verifyOtpRequest(
                          verificationEmail,
                        );
                        if (isVerified) {
                          if (previousScreen == '/signUpScreen') {
                            Get.offAllNamed('/navBarScreen');
                          } else {
                            // Navigate to reset password screen with email
                            try {
                              final forgetController =
                                  Get.find<ForgetPasswordController>(
                                    tag: 'forgetPassword',
                                  );
                              forgetController.verificationEmail =
                                  verificationEmail;
                            } catch (e) {
                              if (kDebugMode) {
                                print('❌ Error setting email: $e');
                              }
                            }
                            Get.offAllNamed('/resetPasswordScreen');
                          }
                        }
                      },
                      color: AppColors.buttonColor,
                      textColor: Colors.white,
                    ),

                    SizedBox(height: 45),
                    Center(
                      child: Obx(() {
                        return controller.showResendButton.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.resendCodeRequest(
                                    verificationEmail,
                                  );
                                },
                                child: Text(
                                  "Resend Code",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.buttonColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            : Text(
                                "Resend in ${controller.formatTime(controller.remainingSeconds.value)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF636363),
                                ),
                              );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
