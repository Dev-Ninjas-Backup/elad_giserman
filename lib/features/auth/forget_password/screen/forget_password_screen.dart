import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:elad_giserman/features/auth/verification/screen/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: AppColors().buildGradientBackground(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(lable: 'forget_password_title'.tr, cancelText: true),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'forget_password_title'.tr,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'forget_password_instructions'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF636363),
                      ),
                    ),
                    SizedBox(height: 30),
                    Obx(
                      () => CustomTextField(
                        labelText: 'email_label'.tr,
                        controller: controller.forgetEmailController,
                        hintText: 'email_hint'.tr,
                        suffixIcon: Icon(Icons.email_outlined),
                        onChanged: (value) => controller.validateEmail(value),
                        errorText: controller.forgetEmailError.value.isEmpty
                            ? null
                            : controller.forgetEmailError.value,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: 'continue_btn'.tr,
                      onPressed: () {
                        Get.to(
                          VerificationScreen(
                            verificationEmail:
                                controller.forgetEmailController.text,
                            previousScreen: '/resetPasswordScreen',
                          ),
                        );
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
      ),
    );
  }
}
