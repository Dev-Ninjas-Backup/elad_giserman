import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationWidget extends StatelessWidget {
  final String? image;
  final String category;
  final String name;
  final String? date;
  final String? time;
  final VoidCallback onPressed;

  const ReservationWidget({
    super.key,
    this.image,
    required this.category,
    required this.name,
    this.date,
    this.time,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: image != null && image!.isNotEmpty
                ? Image.network(
                    image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.restaurant),
                      );
                    },
                  )
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant),
                  ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '# $category',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.fontColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryFontColor,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (date != null && time != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '$date at $time',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.fontColor,
                      ),
                    ),
                  ),
                Spacer(),
                CustomSmallButton(
                  width: 100,
                  text: 'view_details'.tr,
                  onPressed: onPressed,
                  buttonColor: AppColors.buttonColor,
                  fontColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
