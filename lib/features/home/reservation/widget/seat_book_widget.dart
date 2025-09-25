// import 'package:elad_giserman/core/utils/constants/colors.dart';
// import 'package:elad_giserman/core/utils/constants/icon_path.dart';
// import 'package:elad_giserman/features/home/reservation/controller/reservation_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SeatBookWidget extends StatelessWidget {
//   final int leftSeatNumber;
//   final int middleSeatNumber;
//   final int rightSeatNumber;
//   final Color leftSeatColor;
//   final Color middleSeatColor;
//   final Color rightSeatColor;

//   const SeatBookWidget({
//     super.key,
//     required this.leftSeatNumber,
//     required this.middleSeatNumber,
//     required this.rightSeatNumber,
//     required this.leftSeatColor,
//     required this.middleSeatColor,
//     required this.rightSeatColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final ReservationController controller = Get.find<ReservationController>();
//     return Obx(
//       () => Row(
//         children: [
//           GestureDetector(
//             onTap: leftSeatColor == AppColors.color1
//                 ? null
//                 : () {
//                     controller.selectSeat(leftSeatNumber);
//                   },
//             child: Stack(
//               children: [
//                 Image.asset(
//                   IconPath.leftSeat,
//                   height: 62,
//                   width: 52,
//                   color: leftSeatColor == AppColors.color1
//                       ? AppColors.color1
//                       : controller.selectedSeat.value == leftSeatNumber
//                       ? AppColors.color3
//                       : AppColors.color2,
//                 ),
//                 Positioned(
//                   top: 20,
//                   left: 15,
//                   child: Text(
//                     leftSeatNumber.toString(),
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.primaryFontColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: middleSeatColor == AppColors.color1
//                 ? null
//                 : () {
//                     controller.selectSeat(middleSeatNumber);
//                   },
//             child: Stack(
//               children: [
//                 Image.asset(
//                   IconPath.middleSeat,
//                   height: 69,
//                   width: 112,
//                   color: middleSeatColor == AppColors.color1
//                       ? AppColors.color1
//                       : controller.selectedSeat.value == middleSeatNumber
//                       ? AppColors.color3
//                       : AppColors.color2,
//                 ),
//                 Positioned(
//                   top: 23,
//                   right: 50,
//                   child: Text(
//                     middleSeatNumber.toString(),
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.primaryFontColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: rightSeatColor == AppColors.color1
//                 ? null
//                 : () {
//                     controller.selectSeat(rightSeatNumber);
//                   },
//             child: Stack(
//               children: [
//                 Image.asset(
//                   IconPath.rightSeat,
//                   height: 62,
//                   width: 52,
//                   color: rightSeatColor == AppColors.color1
//                       ? AppColors.color1
//                       : controller.selectedSeat.value == rightSeatNumber
//                       ? AppColors.color3
//                       : AppColors.color2,
//                 ),
//                 Positioned(
//                   top: 20,
//                   right: 15,
//                   child: Text(
//                     rightSeatNumber.toString(),
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.primaryFontColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
