import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_password_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
              CustomAppBar(
                lable: 'reset_appbar'.tr,
                cancelText: true,
                back: '/signInScreen',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'reset_title'.tr,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'reset_instructions'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF636363),
                      ),
                    ),
                    SizedBox(height: 30),
                    Obx(
                      () => CustomPasswordTextField(
                        labelText: 'new_password_label'.tr,
                        controller: controller.resetPasswordController,
                        hintText: 'password_hint'.tr,
                        obscureText: !controller.showPassword.value,
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(
                            controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        onChanged: (value) =>
                            controller.validatePassword(value),
                        errorText: controller.resetPasswordError.value.isEmpty
                            ? null
                            : controller.resetPasswordError.value,
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => CustomPasswordTextField(
                        labelText: 'confirm_password_label'.tr,
                        controller: controller.confirmresetPasswordController,
                        hintText: 'password_hint'.tr,
                        obscureText: !controller.showPassword.value,
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(
                            controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        onChanged: (value) =>
                            controller.validatePassword(value),
                        errorText:
                            controller.confirmResetPasswordError.value.isEmpty
                            ? null
                            : controller.confirmResetPasswordError.value,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: 'confirm_password_btn'.tr,
                      onPressed: () {
                        Get.offAllNamed('/signInScreen');
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
