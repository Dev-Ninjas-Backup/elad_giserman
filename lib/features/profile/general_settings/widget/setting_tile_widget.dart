import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';

class SettingTileWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingTileWidget({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
    this.titleColor,
  });
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 46,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.textFieldFillColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor ?? AppColors.primaryFontColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing ??
                Icon(Icons.keyboard_arrow_right, color: AppColors.fontColor),
          ],
        ),
      ),
    );
  }
}
