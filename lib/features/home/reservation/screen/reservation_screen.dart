import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:elad_giserman/core/common/widgets/custom_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/features/home/reservation/controller/reservation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationScreen extends StatefulWidget {
  final String image;
  final String restaurantId;

  const ReservationScreen({
    super.key,
    required this.image,
    required this.restaurantId,
  });

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late ReservationController controller;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ReservationController());
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      controller.selectDate(picked.toString().split(' ')[0]);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hours = picked.hour.toString().padLeft(2, '0');
      final minutes = picked.minute.toString().padLeft(2, '0');
      controller.selectTime('$hours:$minutes');
    }
  }

  Future<void> _submitReservation() async {
    controller.setPhoneNumber(phoneController.text.trim());

    if (!controller.validateFields()) {
      Get.snackbar(
        'Validation Error',
        controller.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final success = await controller.submitReservation(widget.restaurantId);

    if (success) {
      Get.snackbar(
        'Success',
        'Reservation created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    } else {
      Get.snackbar(
        'Error',
        controller.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                // Image.asset(widget.image),
                CustomAppBar(lable: 'reserve_seat'.tr),
                Container(
                  width: Get.width,
                  height: Get.height,
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 40,
                    top: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 11),
                      Container(height: 3, width: 40, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'fill_details'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 20),
                      // Date Picker
                      Text(
                        'select_date'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedDate.value.isEmpty
                                    ? Colors.grey[300]!
                                    : AppColors.buttonColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.textFieldFillColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedDate.value.isEmpty
                                      ? 'Choose date'
                                      : controller.selectedDate.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: controller.selectedDate.value.isEmpty
                                        ? Colors.grey[600]
                                        : AppColors.primaryFontColor,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: AppColors.buttonColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Time Picker
                      Text(
                        'select_time'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedTime.value.isEmpty
                                    ? Colors.grey[300]!
                                    : AppColors.buttonColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.textFieldFillColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedTime.value.isEmpty
                                      ? 'Choose time'
                                      : controller.selectedTime.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: controller.selectedTime.value.isEmpty
                                        ? Colors.grey[600]
                                        : AppColors.primaryFontColor,
                                  ),
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: AppColors.buttonColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Phone Number Field
                      Text(
                        'Phone Number:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          hintStyle: const TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.buttonColor,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Error Message Display
                      Obx(
                        () => controller.errorMessage.value.isNotEmpty
                            ? Column(
                                children: [
                                  Text(
                                    controller.errorMessage.value,
                                    style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                      // Submit Button
                      Obx(
                        () => CustomButton(
                          label: controller.isLoading.value
                              ? 'Loading...'
                              : 'confirm_reservation'.tr,
                          onPressed: controller.isLoading.value
                              ? () {}
                              : _submitReservation,
                          color: controller.isLoading.value
                              ? Colors.grey
                              : AppColors.buttonColor,
                          textColor: Colors.white,
                        ),
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
