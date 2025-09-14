import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/route_manager.dart';

class VerificationScreen extends StatelessWidget {
  final String verificationEmail;
  const VerificationScreen({super.key, required this.verificationEmail});

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
              CustomAppBar(lable: 'Verification', back: '/signUpScreen'),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "We've send you the verification code\non - $verificationEmail",
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
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      label: 'Verify',
                      onPressed: () {
                        Get.offAllNamed('/resetPasswordScreen');
                      },
                      color: AppColors.buttonColor,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 45),
                    Center(
                      child: Text(
                        'Re-send code in 0.20',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF636363),
                        ),
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
