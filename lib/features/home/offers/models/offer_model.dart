class OfferModel {
  final String id;
  final String title;
  final String description;
  final bool isActive;
  final String status;
  final String businessId;
  final String expiredsAt;
  final String code;
  final String qrCodeUrl;
  final String createdAt;
  final String updatedAt;
  final BusinessModel business;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
    required this.status,
    required this.businessId,
    required this.expiredsAt,
    required this.code,
    required this.qrCodeUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.business,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? false,
      status: json['status'] ?? '',
      businessId: json['businessId'] ?? '',
      expiredsAt: json['expiredsAt'] ?? '',
      code: json['code'] ?? '',
      qrCodeUrl: json['qrCodeUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      business: BusinessModel.fromJson(json['business'] ?? {}),
    );
  }
}

class BusinessModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final bool isActive;
  final String openingTime;
  final String closingTime;
  final String? categoryId;
  final String ownerId;
  final String createdAt;
  final String updatedAt;
  final String? profileTypeName;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String? pinterest;
  final String? twitter;
  final String? website;
  final String? youtube;

  BusinessModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.isActive,
    required this.openingTime,
    required this.closingTime,
    this.categoryId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    this.profileTypeName,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.pinterest,
    this.twitter,
    this.website,
    this.youtube,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      isActive: json['isActive'] ?? false,
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      categoryId: json['categoryId'],
      ownerId: json['ownerId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      profileTypeName: json['profileTypeName'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      pinterest: json['pinterest'],
      twitter: json['twitter'],
      website: json['website'],
      youtube: json['youtube'],
    );
  }
}
