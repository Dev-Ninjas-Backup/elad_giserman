import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> vipVoucherDialog() async {
  return Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 340),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              Image.asset(ImagePath.qrCodeScan, height: 146, width: 146),
              const SizedBox(height: 20),
              Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryFontColor,
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                height: 84,
                child: Text(
                  "You have claimed your weekly VIP voucher. You will be eligible for the next VIP voucher at Sep 07, 2025",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryFontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                label: 'Download QR',
                onPressed: () {
                  Get.back();
                },
                color: AppColors.buttonColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
