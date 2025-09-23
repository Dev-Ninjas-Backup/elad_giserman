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

  @override
  Widget build(BuildContext context) {
    final Map<String, String> displayToValue = {
      'filter_all'.tr: 'All',
      'filter_claimed'.tr: 'Claimed',
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
            child: SingleChildScrollView(
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
                    () => Column(
                      children: controller.filteredItems
                          .map(
                            (e) => RedemptionCardWidget(
                              title: e.title,
                              status: e.status,
                              date: e.date,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
