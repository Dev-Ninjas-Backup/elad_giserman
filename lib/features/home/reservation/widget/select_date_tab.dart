import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/reservation/controller/reservation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDateTab extends StatelessWidget {
  final Icon? icon;
  final String title;
  const SelectDateTab({super.key, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final ReservationController controller = Get.find<ReservationController>();
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectDate(title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: controller.selectedDate.value == title
                ? AppColors.buttonColor
                : AppColors.textFieldFillColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // color: textColor ?? AppColors.fontColor,
                  color: controller.selectedDate.value == title
                      ? Colors.white
                      : AppColors.fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
