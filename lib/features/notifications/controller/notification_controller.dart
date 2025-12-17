import 'package:get/get.dart';
import 'package:elad_giserman/features/notifications/model/notification_model.dart';
import 'package:elad_giserman/features/notifications/service/notification_service.dart';

class NotificationController extends GetxController {
  var notificationData = Rxn<NotificationData>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final NotificationService _notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _notificationService.fetchNotifications();
      notificationData.value = response.data;

      print('✅ Notifications fetched successfully');
      print('📲 Today: ${notificationData.value?.today.length ?? 0}');
      print('📲 Previous: ${notificationData.value?.previous.length ?? 0}');
    } catch (e) {
      errorMessage.value = 'Failed to load notifications: $e';
      print('❌ Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
