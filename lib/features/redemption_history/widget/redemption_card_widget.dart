import 'package:flutter/material.dart';
import '../../../core/utils/constants/colors.dart';

class RedemptionCardWidget extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final Widget? leading;

  const RedemptionCardWidget({
    super.key,
    required this.title,
    required this.status,
    required this.date,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child:
                    leading ??
                    Container(
                      width: 64,
                      height: 64,
                      color: Colors.transparent,
                      child: Icon(
                        Icons.qr_code,
                        size: 48,
                        color: AppColors.buttonColor,
                      ),
                    ),
              ),

              Container(
                width: 12,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    10,
                    (i) => Container(
                      width: 2,
                      height: 6,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.primaryFontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        status,
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.3),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
