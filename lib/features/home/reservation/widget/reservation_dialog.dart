import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

Future<void> showConfirmationDialog() async {
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
              Image.asset(
                ImagePath.reservationConfirm,
                height: 146,
                width: 194,
              ),
              const SizedBox(height: 20),
              Text(
                'Reservation Confirmed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryFontColor,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 84,
                child: Text(
                  "Thank you for booking with us! We’re excited to welcome you and make your dining experience unforgettable.",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryFontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  CustomButton(
                    label: 'Got It!',
                    onPressed: () {
                      Get.back();
                    },
                    color: AppColors.buttonColor,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    label: 'Invite Friends',
                    onPressed: () async {
                      // ignore: deprecated_member_use
                      await Share.share(
                        'I just booked a table! Join me for an unforgettable dining experience! 😊',
                        subject: 'Invite Friends to Dine',
                      );
                    },
                    color: AppColors.textFieldFillColor,
                    textColor: AppColors.primaryFontColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
