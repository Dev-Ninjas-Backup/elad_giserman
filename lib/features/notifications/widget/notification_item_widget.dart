import 'package:flutter/material.dart';
import '../../../core/utils/constants/colors.dart';

class NotificationItemWidget extends StatelessWidget {
  final String title;
  final String body;
  final String timeAgo;
  final Color iconColor;
  final IconData icon;
  final bool highlighted;

  const NotificationItemWidget({
    super.key,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.iconColor,
    required this.icon,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: highlighted
          ? EdgeInsets.symmetric(vertical: 12, horizontal: 12)
          : EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: highlighted
          ? BoxDecoration(
              color: AppColors.textFieldFillColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            margin: EdgeInsets.only(right: 12, top: highlighted ? 2 : 0),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Icon(icon, color: iconColor, size: 20)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.primaryFontColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  body,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
