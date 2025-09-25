import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final String image;
  final String title;
  final Color buttonColor;
  final Color iconColor;
  final Color fontColor;
  final VoidCallback onTap; // <-- Added callback

  const TabWidget({
    super.key,
    required this.image,
    required this.title,
    required this.iconColor,
    required this.fontColor,
    required this.buttonColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.fromLTRB(8, 7, 8, 7),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, color: iconColor),
            const SizedBox(width: 5),
            Text(
              title,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
