import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultDialog extends StatelessWidget {
  final String result;
  const ResultDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ), // changed
      // ignore: deprecated_member_use
      backgroundColor: Colors.white.withOpacity(0.95),
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.amber.withOpacity(0.6),
                    blurRadius: 25,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Image.asset(
                IconPath.congratulationIcon,
                width: 90,
                height: 90,
              ), // changed
            ),
            SizedBox(height: 20),
            Text(
              "Congratulations",
              style: TextStyle(
                fontSize: 26,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "You have won $result",
              style: TextStyle(
                fontSize: 19,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ), // changed
                elevation: 6,
              ),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
