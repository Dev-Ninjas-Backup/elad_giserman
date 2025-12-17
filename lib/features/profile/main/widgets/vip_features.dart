import 'package:elad_giserman/core/common/styles/global_text_style.dart';
import 'package:elad_giserman/core/common/widgets/custom_small_button.dart';
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/profile/subscriptions/service/user_subscription_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VipFeatures extends StatefulWidget {
  const VipFeatures({super.key});

  @override
  State<VipFeatures> createState() => _VipFeaturesState();
}

class _VipFeaturesState extends State<VipFeatures> {
  late Future<void> _initFuture;
  final UserSubscriptionService _service = UserSubscriptionService();

  String status = 'PENDING';
  String planTitle = 'Basic';
  String joinedDate = '';
  String expireDate = '';
  String remainingDays = '0';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initFuture = _fetchUserSubscription();
  }

  Future<void> _fetchUserSubscription() async {
    try {
      final response = await _service.fetchUserSubscription();

      if (response != null) {
        if (kDebugMode) {
          print('📋 VipFeatures: Subscription data received');
          print('   Status: ${response.data.status}');
          print('   Plan: ${response.data.plan.title}');
          print('   Joined: ${response.data.period.startedAt}');
          print('   Expires: ${response.data.period.endedAt}');
          print('   Remaining: ${response.data.period.remainingDays}');
        }

        // Format dates to a professional format (e.g., "Dec 13, 2025")
        final formattedJoinedDate = _formatDate(response.data.period.startedAt);
        final formattedExpireDate = _formatDate(response.data.period.endedAt);

        setState(() {
          status = response.data.status;
          planTitle = response.data.plan.title;
          joinedDate = formattedJoinedDate;
          expireDate = formattedExpireDate;
          remainingDays = response.data.period.remainingDays;
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print(
            '❌ VipFeatures: Failed to load subscription - response is null',
          );
        }
        setState(() {
          errorMessage = 'Failed to load subscription';
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ VipFeatures: Error loading subscription: $e');
      }
      setState(() {
        errorMessage = 'Error loading subscription';
        isLoading = false;
      });
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case 'ACTIVE':
        return 'vip_status_active'.tr;
      case 'PENDING':
        return 'vip_status_pending'.tr;
      case 'EXPIRED':
        return 'vip_status_expired'.tr;
      default:
        return status;
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case 'ACTIVE':
        return Color(0xFF00CC00);
      case 'PENDING':
        return Color(0xFFFFAA00);
      case 'EXPIRED':
        return Color(0xFFFF3300);
      default:
        return Color(0xFFFF3300);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (kDebugMode) {
          print('🔄 VipFeatures: Building widget - isLoading: $isLoading');
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: Colors.white24,
                      ),
                      child: Text(
                        _getStatusLabel(),
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _getStatusColor(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'vip_activated'.tr,
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    if (isLoading)
                      SizedBox(
                        height: 60,
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'vip_plan'.trParams({'plan': planTitle}),
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'vip_joining_date'.trParams({'date': joinedDate}),
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'vip_expire_date'.trParams({'date': expireDate}),
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'vip_remaining_days'.trParams({
                              'days': remainingDays,
                            }),
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 24),
                    CustomSmallButton(
                      text: 'vip_renew_btn'.tr,
                      onPressed: () {
                        Get.offNamed('/subscriptionScreen');
                      },
                      buttonColor: Colors.white,
                      fontColor: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Image.asset(ImagePath.strawGlass, scale: 3),
            ],
          ),
        );
      },
    );
  }
}
