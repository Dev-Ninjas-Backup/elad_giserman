import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/features/profile/main/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF5F5F5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'logout'.tr,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: controller.isLoggingOut.value
                  ? null
                  : () {
                      controller.logout();
                    },
              icon: controller.isLoggingOut.value
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : Icon(Icons.logout, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
