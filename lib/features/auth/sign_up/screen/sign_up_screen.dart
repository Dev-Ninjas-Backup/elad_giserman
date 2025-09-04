import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/common/widgets/custom_text_field.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                CustomAppBar(lable: 'Sign Up'),
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
                        controller: TextEditingController(),
                        hintText: 'Full Name',
                        onChanged: (String value) {},
                        suffixIcon: Icon(Icons.person_outline),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        labelText: 'Email',
                        controller: TextEditingController(),
                        hintText: 'example@gmail.com',
                        onChanged: (String value) {},
                      ),
                      SizedBox(height: 24),
                      CustomButton(
                        label: 'Sign Up',
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
