import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(28, 96, 28, 20),
        height: MediaQuery.of(context).size.height,
        decoration: AppColors().buildGradientBackground(context),
        child: Center(
          child: Obx(() {
            final logoUrl = controller.logoUrl;
            if (logoUrl.isNotEmpty) {
              return Image.network(
                logoUrl,
                height: 48,
                width: 190,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(IconPath.appIcon, height: 48, width: 190);
                },
              );
            } else {
              return Image.asset(IconPath.appIcon, height: 48, width: 190);
            }
          }),
        ),
      ),
    );
  }
}
