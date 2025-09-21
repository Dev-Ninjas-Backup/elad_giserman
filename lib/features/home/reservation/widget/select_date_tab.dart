import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectDateTab extends StatelessWidget {
  final Icon? icon;
  final Color buttonColor;
  final Color? textColor;
  final String title;
  const SelectDateTab({
    super.key,
    required this.buttonColor,
    this.icon,
    required this.title,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: buttonColor,
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
              color: textColor ?? AppColors.fontColor,
            ),
          ),
        ],
      ),
    );
  }
}
