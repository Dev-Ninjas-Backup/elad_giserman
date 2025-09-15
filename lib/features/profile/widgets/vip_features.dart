import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class VipFeatures extends StatelessWidget {
  const VipFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: Colors.white24,
                ),
                child: Text(
                  '• Expired',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFF3300),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'VIP features activated',
                style: getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Joining Date: Jul 15, 2025',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Expire Date: Aug 15,2025',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              CustomSmallButton(
                text: 'Renew Subscription',
                onPressed: () {},
                buttonColor: Colors.white,
                fontColor: Colors.black,
              ),
            ],
          ),
          Spacer(),
          Image.asset(ImagePath.strawGlass, height: 200, width: 120),
        ],
      ),
    );
  }
}
