import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/profile/widgets/reservation_widget.dart';
import 'package:flutter/material.dart';

class ReservationHistoryScreen extends StatelessWidget {
  const ReservationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(lable: 'Reservation History', back: '/navBarScreen'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  ReservationWidget(
                    image: ImagePath.recommended1,
                    category: 'Restaurant',
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {},
                  ),
                  SizedBox(height: 12),
                  ReservationWidget(
                    image: ImagePath.recommended1,
                    category: 'Restaurant',
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {},
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'Last Week',
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  ReservationWidget(
                    image: ImagePath.restaurant2,
                    category: 'Cafe',
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {},
                  ),
                  SizedBox(height: 12),
                  ReservationWidget(
                    image: ImagePath.restaurant2,
                    category: 'Bar',
                    name: 'Olive & Thyme Mediterranean Kitchen',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
