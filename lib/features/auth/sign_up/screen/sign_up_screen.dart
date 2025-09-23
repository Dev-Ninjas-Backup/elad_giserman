import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_password_text_field.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/auth/sign_up/controller/sign_up_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: AppColors().buildGradientBackground(context),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(lable: 'sign_up_title'.tr, back: '/signInScreen'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'sign_up_title'.tr,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Obx(
                        () => CustomTextField(
                          labelText: 'username_label'.tr,
                          controller: controller.usernameController,
                          hintText: 'username_hint'.tr,
                          onChanged: (value) =>
                              controller.validateUsername(value),
                          errorText: controller.usernameError.value.isEmpty
                              ? null
                              : controller.usernameError.value,
                          suffixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextField(
                          labelText: 'email_label'.tr,
                          controller: controller.emailController,
                          hintText: 'email_hint'.tr,
                          onChanged: (value) => controller.validateEmail(value),
                          errorText: controller.emailError.value.isEmpty
                              ? null
                              : controller.emailError.value,
                          suffixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomPasswordTextField(
                          labelText: 'password_label'.tr,
                          controller: controller.passwordController,
                          hintText: '********',
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
                          errorText: controller.passwordError.value.isEmpty
                              ? null
                              : controller.passwordError.value,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomPasswordTextField(
                          labelText: 'confirm_password_label'.tr,
                          controller: controller.confirmPasswordController,
                          hintText: '********',
                          obscureText: !controller.showConfirmPassword.value,
                          suffixIcon: IconButton(
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                            icon: Icon(
                              controller.showConfirmPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          onChanged: (value) =>
                              controller.validateConfirmPassword(value),
                          errorText:
                              controller.confirmPasswordError.value.isEmpty
                              ? null
                              : controller.confirmPasswordError.value,
                        ),
                      ),
                      SizedBox(height: 24),
                      CustomButton(
                        label: 'sign_up_btn'.tr,
                        onPressed: () {
                          controller.signUp();
                        },
                        color: AppColors.buttonColor,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'or_text'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomButton(
                        label: 'login_with_google'.tr,
                        onPressed: () {
                          controller.signUpWithGoogle();
                        },
                        color: Colors.white,
                        textColor: AppColors.primaryFontColor,
                        icon: Image.asset(IconPath.googleIcon),
                      ),
                      SizedBox(height: 40),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '${'already_have_account'.tr} ',
                          style: TextStyle(
                            color: AppColors.primaryFontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${'sign_in'.tr}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed('/signInScreen');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
