import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;

  const CustomSmallButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 28,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: height,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
