import 'package:elad_giserman/features/profile/redemption_history/model/redemption_model.dart';
import 'package:elad_giserman/features/profile/redemption_history/service/redemption_history_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RedemptionHistoryController extends GetxController {
  final RedemptionHistoryService _service = RedemptionHistoryService();

  final RxList<RedemptionItem> allItems = <RedemptionItem>[].obs;
  final RxString filter = 'All'.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRedeemedItems();
  }

  Future<void> fetchRedeemedItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final items = await _service.fetchRedeemedItems();
      allItems.value = items;

      if (kDebugMode) {
        print("✅ Redeemed items loaded: ${items.length}");
      }
    } catch (e) {
      errorMessage.value = 'Failed to load redeemed items';
      if (kDebugMode) {
        print("❌ Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filterValue) {
    filter.value = filterValue;
  }

  Future<bool> claimRedemption(String redemptionId) async {
    try {
      isLoading.value = true;
      await _service.claimRedemption(redemptionId);

      // Refresh the list after claiming
      await fetchRedeemedItems();

      if (kDebugMode) {
        print("✅ Redemption claimed successfully");
      }
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to claim redemption';
      if (kDebugMode) {
        print("❌ Error claiming redemption: $e");
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  List<RedemptionItem> get filteredItems {
    if (filter.value == 'All') {
      return allItems;
    } else if (filter.value == 'Claimed') {
      return allItems.where((item) => item.status == 'Claimed').toList();
    } else if (filter.value == 'Unclaimed') {
      return allItems.where((item) => item.status == 'Unclaimed').toList();
    } else if (filter.value == 'Expired') {
      return allItems.where((item) => item.status == 'Expired').toList();
    }
    return allItems;
  }
}
