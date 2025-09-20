import 'package:get/get.dart';
import '../model/redemption_item_model.dart';

class RedemptionHistoryController extends GetxController {
  final items = <RedemptionItemModel>[].obs;
  final filter = 'All'.obs;

  List<RedemptionItemModel> get filteredItems {
    if (filter.value == 'All') return items;
    return items.where((e) => e.status == filter.value).toList();
  }

  @override
  void onInit() {
    super.onInit();
    items.assignAll([
      RedemptionItemModel(
        title: 'The Fantasy Cocktail',
        status: 'Claimed',
        date: '23 Aug 2025',
      ),
      RedemptionItemModel(
        title: 'The Fantasy Cocktail',
        status: 'Claimed',
        date: '16 Aug 2025',
      ),
      RedemptionItemModel(
        title: 'The Fantasy Cocktail',
        status: 'Claimed',
        date: '09 Aug 2025',
      ),
      RedemptionItemModel(
        title: 'The Fantasy Cocktail',
        status: 'Claimed',
        date: '02 Aug 2025',
      ),
    ]);
  }

  void setFilter(String value) {
    filter.value = value;
  }
}
