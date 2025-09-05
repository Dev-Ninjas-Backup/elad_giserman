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
                CustomAppBar(lable: 'Sign Up', routeName: '/signInScreen'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      CustomTextField(
                        labelText: 'Username',
                        controller: controller.usernameController,
                        hintText: 'Full Name',
                        onChanged: (value) =>
                            controller.validateUsername(value),
                        errorText: controller.usernameError.value.isEmpty
                            ? null
                            : controller.usernameError.value,
                        suffixIcon: Icon(Icons.person_outline),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Email',
                        controller: controller.emailController,
                        hintText: 'example@gmail.com',
                        onChanged: (value) => controller.validateEmail(value),
                        errorText: controller.emailError.value.isEmpty
                            ? null
                            : controller.emailError.value,
                        suffixIcon: Icon(Icons.email_outlined),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomPasswordTextField(
                          labelText: 'Password',
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
                          labelText: 'Confirm Password',
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
                        label: 'Sign Up',
                        onPressed: () {
                          controller.signUp();
                        },
                        color: AppColors.buttonColor,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomButton(
                        label: 'Login with Google',
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
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: AppColors.primaryFontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign In',
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
