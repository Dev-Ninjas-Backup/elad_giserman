class RedemptionItem {
  final String id;
  final String code;
  final String title;
  final String businessTitle;
  final String status; // 'Claimed' or 'Expired'
  final String date;
  final String description;
  final String offerId;
  final String offerCode;
  final String offerDescription;
  final String? qrCodeUrl;
  final String expiresAt;
  final bool isActive;
  final String offerStatus;

  RedemptionItem({
    required this.id,
    required this.code,
    required this.title,
    required this.businessTitle,
    required this.status,
    required this.date,
    required this.description,
    required this.offerId,
    required this.offerCode,
    required this.offerDescription,
    required this.qrCodeUrl,
    required this.expiresAt,
    required this.isActive,
    required this.offerStatus,
  });

  factory RedemptionItem.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    final offer = json['offer'] as Map<String, dynamic>? ?? {};
    final business = json['business'] as Map<String, dynamic>? ?? {};

    // Use offer's expiredsAt for expiration date
    final offerExpiresAtStr = offer['expiredsAt'] as String?;
    final redeemedAtStr = json['redeemedAt'] as String?;

    final offerExpiresAt = offerExpiresAtStr != null
        ? DateTime.parse(offerExpiresAtStr)
        : DateTime.now();
    final redeemedAt = redeemedAtStr != null
        ? DateTime.parse(redeemedAtStr)
        : DateTime.now();

    // Determine status based on isClaimed field
    String status = 'Unclaimed';
    final isClaimed = json['isClaimed'] as bool? ?? false;
    if (isClaimed) {
      status = 'Claimed';
    } else if (offerExpiresAt.isBefore(now)) {
      status = 'Expired';
    }

    return RedemptionItem(
      id: json['id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      title: offer['title'] as String? ?? 'Unknown Offer',
      businessTitle: business['title'] as String? ?? 'Unknown Business',
      status: status,
      date: _formatDate(redeemedAt),
      description: offer['description'] as String? ?? '',
      offerId: offer['id'] as String? ?? '',
      offerCode: offer['code'] as String? ?? '',
      offerDescription: offer['description'] as String? ?? '',
      qrCodeUrl: offer['qrCodeUrl'] as String?,
      expiresAt: _formatDate(offerExpiresAt),
      isActive: offer['isActive'] as bool? ?? false,
      offerStatus: offer['status'] as String? ?? 'PENDING',
    );
  }

  static String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
