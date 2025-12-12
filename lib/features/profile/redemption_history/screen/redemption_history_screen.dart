import 'package:elad_giserman/core/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants/colors.dart';
import '../controller/redemption_history_controller.dart';
import '../widget/redemption_card_widget.dart';

class RedemptionHistoryScreen extends StatelessWidget {
  final RedemptionHistoryController controller = Get.put(
    RedemptionHistoryController(),
  );

  RedemptionHistoryScreen({super.key});

  void _showClaimConfirmationDialog(
    BuildContext context,
    String redemptionId,
    String offerTitle,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Confirm Claim',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Are you sure you want to claim "$offerTitle"?',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                final success = await controller.claimRedemption(redemptionId);

                if (success) {
                  Get.snackbar(
                    'Success',
                    'Offer claimed successfully!',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    controller.errorMessage.value,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                }
              },
              child: const Text('Claim', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> displayToValue = {
      'filter_all'.tr: 'All',
      'filter_claimed'.tr: 'Claimed',
      'Unclaimed': 'Unclaimed',
      'filter_expired'.tr: 'Expired',
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppBar(
            lable: 'redemption_history_title'.tr,
            back: '/navBarScreen',
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttonColor,
                  ),
                );
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }

              if (controller.allItems.isEmpty) {
                return Center(
                  child: Text(
                    'No redeemed items',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 16),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => PopupMenuButton<String>(
                        onSelected: (v) {
                          final internal = displayToValue[v] ?? 'All';
                          controller.setFilter(internal);
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'filter_all'.tr,
                            child: Text('filter_all'.tr),
                          ),
                          PopupMenuItem(
                            value: 'filter_claimed'.tr,
                            child: Text('filter_claimed'.tr),
                          ),
                          PopupMenuItem(
                            value: 'Unclaimed',
                            child: Text('Unclaimed'),
                          ),
                          PopupMenuItem(
                            value: 'filter_expired'.tr,
                            child: Text('filter_expired'.tr),
                          ),
                        ],
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.textFieldFillColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                displayToValue.entries
                                    .firstWhere(
                                      (e) => e.value == controller.filter.value,
                                      orElse: () =>
                                          MapEntry('filter_all'.tr, 'All'),
                                    )
                                    .key,
                                style: TextStyle(
                                  color: AppColors.primaryFontColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: AppColors.primaryFontColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => controller.filteredItems.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Text(
                                  'No items match this filter',
                                  style: TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: controller.filteredItems
                                  .map(
                                    (e) => RedemptionCardWidget(
                                      title: e.title,
                                      status: e.status,
                                      date: e.date,
                                      businessTitle: e.businessTitle,
                                      code: e.code,
                                      id: e.id,
                                      onClaim: () =>
                                          _showClaimConfirmationDialog(
                                            context,
                                            e.id,
                                            e.title,
                                          ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
