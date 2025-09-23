import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/reservation/controller/reservation_controller.dart';
import 'package:elad_giserman/features/home/reservation/widget/reservation_dialog.dart';
import 'package:elad_giserman/features/home/reservation/widget/seat_book_widget.dart';
import 'package:elad_giserman/features/home/reservation/widget/select_date_tab.dart';
import 'package:elad_giserman/features/home/reservation/widget/select_time_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationScreen extends StatelessWidget {
  final String image;
  const ReservationScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Get.put(ReservationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image.asset(image),
                CustomAppBar(lable: 'reserve_seat'.tr),
                Container(
                  width: Get.width,
                  height: Get.height,
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 11),
                      Container(height: 3, width: 40, color: Colors.grey),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'fill_details'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 14),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'select_date'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          SelectDateTab(title: 'today'.tr),
                          SizedBox(width: 8),
                          SelectDateTab(title: 'tomorrow'.tr),
                          SizedBox(width: 8),
                          SelectDateTab(
                            icon: Icon(Icons.calendar_month),
                            title: 'choose_date'.tr,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'select_time'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          SelectTimeTab(title: '12:00 PM - 03:00 PM'),
                          SizedBox(width: 8),
                          SelectTimeTab(title: '05:00 PM - 08:00 PM'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SelectTimeTab(
                          title: 'choose_time'.tr,
                          icon: Icon(Icons.alarm),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'choose_seat'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 13),
                      SeatBookWidget(
                        leftSeatNumber: 1,
                        middleSeatNumber: 2,
                        rightSeatNumber: 3,
                        leftSeatColor: AppColors.color2,
                        middleSeatColor: AppColors.color1,
                        rightSeatColor: AppColors.color2,
                      ),
                      SizedBox(height: 22),
                      SeatBookWidget(
                        leftSeatNumber: 4,
                        middleSeatNumber: 5,
                        rightSeatNumber: 6,
                        leftSeatColor: AppColors.color2,
                        middleSeatColor: AppColors.color3,
                        rightSeatColor: AppColors.color1,
                      ),
                      SizedBox(height: 247),
                      CustomButton(
                        label: 'confirm_reservation'.tr,
                        onPressed: () {
                          showConfirmationDialog();
                        },
                        color: AppColors.buttonColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
