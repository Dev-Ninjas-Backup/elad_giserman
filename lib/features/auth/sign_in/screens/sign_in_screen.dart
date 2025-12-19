import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_password_text_field.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/auth/sign_in/controller/sign_in_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: AppColors().buildGradientBackground(context),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Obx(() {
                    final logoUrl = controller.logoUrl;
                    if (logoUrl.isNotEmpty) {
                      return Image.network(
                        logoUrl,
                        height: 48,
                        width: 190,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            IconPath.appIcon,
                            height: 48,
                            width: 190,
                          );
                        },
                      );
                    } else {
                      return Image.asset(
                        IconPath.appIcon,
                        height: 48,
                        width: 190,
                      );
                    }
                  }),
                  SizedBox(height: 97),
                  Center(
                    child: Text(
                      'sign_in_title'.tr,
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
                      labelText: 'email_label'.tr,
                      controller: controller.emailController,
                      hintText: 'email_hint'.tr,
                      suffixIcon: Icon(Icons.email_outlined),
                      onChanged: (value) => controller.validateEmail(value),
                      errorText: controller.emailError.value.isEmpty
                          ? null
                          : controller.emailError.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => CustomPasswordTextField(
                      labelText: 'password_label'.tr,
                      controller: controller.passwordController,
                      obscureText: !controller.showPassword.value,
                      hintText: 'password_hint'.tr,
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: Icon(
                          controller.showPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xFF636363),
                        ),
                      ),
                      errorText: controller.passwordError.value.isEmpty
                          ? null
                          : controller.passwordError.value,
                      onChanged: (value) => controller.validatePassword(value),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
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
                      SizedBox(width: 10),
                      Text(
                        'remember_me'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/forgetPasswordScreen');
                        },
                        child: Text(
                          'forget_password'.tr,
                          style: TextStyle(
                            color: Color(0xFF0088A3),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  CustomButton(
                    label: 'log_in'.tr,
                    onPressed: () {
                      controller.signIn();
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
                      controller.signInWithGoogle();
                    },
                    color: Colors.white,
                    textColor: AppColors.primaryFontColor,
                    icon: Image.asset(
                      IconPath.googleIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  SizedBox(height: 40),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '${'dont_have_account'.tr} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${'sign_up'.tr}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed('/signUpScreen');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
