import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordController controller;

  @override
  void initState() {
    super.initState();
    // Create a new controller instance for this screen
    controller = ForgetPasswordController();
  }

  @override
  void dispose() {
    // Don't dispose the controller here - we'll reuse it in the next screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Obx(
                      () => CustomButton(
                        label: 'continue_btn'.tr,
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                final success = await controller
                                    .sendForgetPassword();

                                if (success) {
                                  // Store email for reset password
                                  controller.verificationEmail =
                                      controller.forgetEmailController.text;
                                  // Put controller in Get for the next screen
                                  Get.put(
                                    controller,
                                    tag: 'forgetPassword',
                                    permanent: true,
                                  );
                                  // Navigate directly to reset password screen
                                  Get.toNamed('/resetPasswordScreen');
                                }
                              },
                        color: AppColors.buttonColor,
                        textColor: Colors.white,
                      ),
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
