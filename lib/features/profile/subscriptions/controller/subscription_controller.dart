import 'package:elad_giserman/features/profile/subscriptions/model/subscription_model.dart';
import 'package:elad_giserman/features/profile/subscriptions/service/subscription_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final SubscriptionService _service = SubscriptionService();

  final Rx<SubscriptionResponse?> subscriptionResponse = Rx(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isMonthlySelected = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print('🔄 SubscriptionController initialized');
    }
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    try {
      if (kDebugMode) {
        print('🔄 Starting to fetch subscriptions...');
      }
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _service.fetchSubscriptions();

      if (response != null) {
        subscriptionResponse.value = response;
        if (kDebugMode) {
          print('✅ Subscriptions loaded successfully');
          print('   Monthly Plan: ${response.data.monthlyPlan?.title ?? 'None'}');
          print('   Yearly Plan: ${response.data.yearlyPlan?.title ?? 'None'}');
          print('   Biannual Plan: ${response.data.biannualPlan?.title ?? 'None'}');
          print('   Current selected: ${isMonthlySelected.value ? 'Monthly' : 'Yearly'}');
          print('   Current Plan: ${currentPlan?.title}');
          print('   Current Price: ${currentPlan?.formattedPrice}');
          print('   Benefits: ${currentPlan?.benefits.length ?? 0}');
        }
      } else {
        errorMessage.value = 'Failed to load subscription plans';
        if (kDebugMode) {
          print('❌ Failed to load subscriptions - response is null');
        }
      }
    } catch (e) {
      errorMessage.value = 'Error loading subscriptions: ${e.toString()}';
      if (kDebugMode) {
        print('❌ Exception caught in fetchSubscriptions: $e');
        print('   Error type: ${e.runtimeType}');
      }
    } finally {
      isLoading.value = false;
      if (kDebugMode) {
        print('📋 isLoading set to false');
      }
    }
  }

  void toggleBillingPeriod(bool isMonthly) {
    if (kDebugMode) {
      print('🔄 Toggling billing period from ${isMonthlySelected.value ? "Monthly" : "Yearly"} to ${isMonthly ? "Monthly" : "Yearly"}');
    }
    isMonthlySelected.value = isMonthly;
    if (kDebugMode) {
      print('✅ Billing period toggled');
      print('   Selected: ${isMonthlySelected.value ? "Monthly" : "Yearly"}');
      print('   Current Plan: ${currentPlan?.title}');
      print('   Current Price: ${currentPlan?.formattedPrice}');
    }
  }

  SubscriptionPlan? get currentPlan {
    if (subscriptionResponse.value == null) {
      if (kDebugMode) {
        print('⚠️ currentPlan getter: subscriptionResponse is null');
      }
      return null;
    }
    final plan = isMonthlySelected.value
        ? subscriptionResponse.value!.data.monthlyPlan
        : subscriptionResponse.value!.data.yearlyPlan ??
            subscriptionResponse.value!.data.monthlyPlan;
    if (kDebugMode) {
      print('📋 currentPlan getter called');
      print('   Monthly selected: ${isMonthlySelected.value}');
      print('   Plan: ${plan?.title}');
    }
    return plan;
  }
}
