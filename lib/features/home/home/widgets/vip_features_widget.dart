import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class VipFeaturesWidget extends StatelessWidget {
  const VipFeaturesWidget({super.key});

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
              Text(
                'Upgrade to Premium\n& Unlock VIP Features',
                style: getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Enjoy more with weekly free\ndrinks & first class seats\naccess at live events.',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomSmallButton(
                  text: 'Go Premium',
                  onPressed: () {},
                  buttonColor: Colors.white,
                  fontColor: Colors.black,
                ),
              ),
            ],
          ),
          Spacer(),
          Image.asset(ImagePath.strawGlass, scale: 4),
        ],
      ),
    );
  }
}
