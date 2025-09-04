import 'package:elad_giserman/core/common/widgets/custom_button.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(28, 96, 28, 20),
          height: MediaQuery.of(context).size.height,
          decoration: AppColors().buildGradientBackground(context),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(IconPath.appIcon, height: 48, width: 190),
                SizedBox(height: 97),
                Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomTextField(
                  labelText: 'Email',
                  controller: controller.emailController,
                  hintText: 'example@gmail.com',
                  onChanged: (value) => controller.validateEmail(value),
                  suffixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 20),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryFontColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: !controller.showPassword.value,
                    decoration: InputDecoration(
                      hintText: '*********',
                      hintStyle: TextStyle(
                        color: Color(0xFF636363),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldFillColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
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
                    ),
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
                      'Remember me',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
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
                  label: 'Log In',
                  onPressed: () {},
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
                  onPressed: () {},
                  color: Colors.white,
                  textColor: AppColors.primaryFontColor,
                  icon: Image.asset(IconPath.googleIcon, height: 24, width: 24),
                ),
                SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
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
    );
  }
}
