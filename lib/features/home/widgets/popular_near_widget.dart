import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class PopularNearWidget extends StatelessWidget {
  const PopularNearWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 1, color: Color(0xFFEBEBEB)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: Image.asset(
              ImagePath.popularRestaurant1,
              height: 130,
              width: Get.width,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                Icon(Icons.star, size: 12, color: Colors.deepOrangeAccent),
                SizedBox(width: 6),
                Text(
                  '4.9 (327 reviews)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF636363),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Olive & Thyme Mediterranean Kitchen',
              style: TextStyle(
                color: AppColors.primaryFontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(
              left: 8,
              right: 8,
              top: 6,
              bottom: 12,
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text('Rothschild Blvd 22,\nTel Aviv, Israel'),
              ],
            ),
          ),
          CustomSmallButton(text: 'Reserve a Seat', onPressed: () {}),
        ],
      ),
    );
  }
}
