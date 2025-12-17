class UserSubscriptionResponse {
  final bool success;
  final String message;
  final UserSubscriptionData data;

  UserSubscriptionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return UserSubscriptionResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: UserSubscriptionData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UserSubscriptionData {
  final String status;
  final bool canSubscribe;
  final UserSubscriptionPlan plan;
  final SubscriptionPeriod period;
  final String message;

  UserSubscriptionData({
    required this.status,
    required this.canSubscribe,
    required this.plan,
    required this.period,
    required this.message,
  });

  factory UserSubscriptionData.fromJson(Map<String, dynamic> json) {
    return UserSubscriptionData(
      status: json['status'] as String,
      canSubscribe: json['canSubscribe'] as bool,
      plan: UserSubscriptionPlan.fromJson(json['plan'] as Map<String, dynamic>),
      period: SubscriptionPeriod.fromJson(json['period'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  bool get isActive => status == 'ACTIVE';
  bool get isPending => status == 'PENDING';
  bool get isExpired => status == 'EXPIRED';
}

class UserSubscriptionPlan {
  final String title;
  final int price;
  final String currency;
  final String billingPeriod;

  UserSubscriptionPlan({
    required this.title,
    required this.price,
    required this.currency,
    required this.billingPeriod,
  });

  factory UserSubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return UserSubscriptionPlan(
      title: json['title'] as String,
      price: json['price'] as int,
      currency: json['currency'] as String,
      billingPeriod: json['billingPeriod'] as String,
    );
  }

  String get formattedPrice => '\$${(price / 100).toStringAsFixed(2)}';
}

class SubscriptionPeriod {
  final String startedAt;
  final String endedAt;
  final String remainingDays;

  SubscriptionPeriod({
    required this.startedAt,
    required this.endedAt,
    required this.remainingDays,
  });

  factory SubscriptionPeriod.fromJson(Map<String, dynamic> json) {
    return SubscriptionPeriod(
      startedAt: json['startedAt'] as String,
      endedAt: json['endedAt'] as String,
      remainingDays: json['remainingDays'] as String,
    );
  }
}
