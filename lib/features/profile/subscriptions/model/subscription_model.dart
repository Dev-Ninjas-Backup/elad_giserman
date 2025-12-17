class SubscriptionResponse {
  final bool success;
  final String message;
  final SubscriptionData data;

  SubscriptionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SubscriptionData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class SubscriptionData {
  final SubscriptionPlan? monthlyPlan;
  final SubscriptionPlan? biannualPlan;
  final SubscriptionPlan? yearlyPlan;

  SubscriptionData({
    required this.monthlyPlan,
    required this.biannualPlan,
    required this.yearlyPlan,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      monthlyPlan: json['monthlyPlan'] != null
          ? SubscriptionPlan.fromJson(
              json['monthlyPlan'] as Map<String, dynamic>,
            )
          : null,
      biannualPlan: json['biannualPlan'] != null
          ? SubscriptionPlan.fromJson(
              json['biannualPlan'] as Map<String, dynamic>,
            )
          : null,
      yearlyPlan: json['yearlyPlan'] != null
          ? SubscriptionPlan.fromJson(
              json['yearlyPlan'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class SubscriptionPlan {
  final String id;
  final String title;
  final String? description;
  final List<String> benefits;
  final bool isPopular;
  final bool isActive;
  final String stripeProductId;
  final String stripePriceId;
  final String currency;
  final int priceCents;
  final int priceWithoutDiscountCents;
  final int discountPercent;
  final String billingPeriod;
  final String createdAt;
  final String updatedAt;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.benefits,
    required this.isPopular,
    required this.isActive,
    required this.stripeProductId,
    required this.stripePriceId,
    required this.currency,
    required this.priceCents,
    required this.priceWithoutDiscountCents,
    required this.discountPercent,
    required this.billingPeriod,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      benefits: List<String>.from(json['benefits'] as List),
      isPopular: json['isPopular'] as bool,
      isActive: json['isActive'] as bool,
      stripeProductId: json['stripeProductId'] as String,
      stripePriceId: json['stripePriceId'] as String,
      currency: json['currency'] as String,
      priceCents: json['priceCents'] as int,
      priceWithoutDiscountCents: json['priceWithoutDiscountCents'] as int,
      discountPercent: json['discountPercent'] as int,
      billingPeriod: json['billingPeriod'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  String get formattedPrice {
    final dollars = priceCents / 100;
    return '\$${dollars.toStringAsFixed(2)}';
  }
}
