import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(28, 96, 28, 20),
        height: MediaQuery.of(context).size.height,
        decoration: AppColors().buildGradientBackground(context),
        child: Center(
          child: Image.asset(
            'assets/icons/appIcon.png',
            height: 48,
            width: 190,
          ),
        ),
      ),
    );
  }
}
