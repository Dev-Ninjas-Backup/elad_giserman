import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ReservationScreen extends StatelessWidget {
  final String image;
  const ReservationScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(image),
                CustomAppBar(lable: 'Reserve Seat'),
                Container(
                  width: Get.width,
                  height: Get.height,
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
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
