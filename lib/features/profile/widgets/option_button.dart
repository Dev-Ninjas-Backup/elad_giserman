import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final VoidCallback button;
  const OptionButton({super.key, required this.title, required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryFontColor,
            ),
          ),
          IconButton(
            onPressed: button,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryFontColor,
            ),
          ),
        ],
      ),
    );
  }
}
