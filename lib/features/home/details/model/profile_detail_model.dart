class Offer {
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

  Offer({
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
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
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
    );
  }
}

class ReviewReply {
  final String id;
  final String comment;
  final String reviewId;
  final String userId;
  final String createdAt;
  final String updatedAt;

  ReviewReply({
    required this.id,
    required this.comment,
    required this.reviewId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewReply.fromJson(Map<String, dynamic> json) {
    return ReviewReply(
      id: json['id'] ?? '',
      comment: json['comment'] ?? '',
      reviewId: json['reviewId'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Review {
  final String id;
  final String comment;
  final int rating;
  final String userId;
  final String businessId;
  final String createdAt;
  final String updatedAt;
  final List<ReviewReply> replies;

  Review({
    required this.id,
    required this.comment,
    required this.rating,
    required this.userId,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    this.replies = const [],
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      userId: json['userId'] ?? '',
      businessId: json['businessId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map(
                (item) => ReviewReply.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class BusinessProfileDetail {
  final String id;
  final String title;
  final String description;
  final String location;
  final bool isActive;
  final String openingTime;
  final String closingTime;
  final String categoryId;
  final String profileTypeName;
  final String ownerId;
  final String facebook;
  final String instagram;
  final String twitter;
  final String website;
  final String linkedin;
  final String pinterest;
  final String youtube;
  final String createdAt;
  final String updatedAt;
  final List<GalleryItem> gallery;
  final List<Offer> offers;
  final List<Review> reviews;
  final double? rating;
  final int reviewCount;

  BusinessProfileDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.isActive,
    required this.openingTime,
    required this.closingTime,
    required this.categoryId,
    required this.profileTypeName,
    required this.ownerId,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.website,
    required this.linkedin,
    required this.pinterest,
    required this.youtube,
    required this.createdAt,
    required this.updatedAt,
    required this.gallery,
    required this.offers,
    required this.reviews,
    this.rating,
    this.reviewCount = 0,
  });

  factory BusinessProfileDetail.fromJson(Map<String, dynamic> json) {
    return BusinessProfileDetail(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      isActive: json['isActive'] ?? false,
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      categoryId: json['categoryId'] ?? '',
      profileTypeName: json['profileTypeName'] ?? '',
      ownerId: json['ownerId'] ?? '',
      facebook: json['facebook'] ?? '',
      instagram: json['instagram'] ?? '',
      twitter: json['twitter'] ?? '',
      website: json['website'] ?? '',
      linkedin: json['linkedin'] ?? '',
      pinterest: json['pinterest'] ?? '',
      youtube: json['youtube'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map(
                (item) => GalleryItem.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      offers:
          (json['offers'] as List<dynamic>?)
              ?.map((item) => Offer.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((item) => Review.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      rating: json['rating'] is num ? (json['rating'] as num).toDouble() : null,
      reviewCount: json['reviewCount'] ?? 0,
    );
  }
}

class GalleryItem {
  final String id;
  final String filename;
  final String originalFilename;
  final String path;
  final String url;
  final String fileType;
  final String mimeType;
  final int size;
  final String createdAt;
  final String updatedAt;

  GalleryItem({
    required this.id,
    required this.filename,
    required this.originalFilename,
    required this.path,
    required this.url,
    required this.fileType,
    required this.mimeType,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'] ?? '',
      filename: json['filename'] ?? '',
      originalFilename: json['originalFilename'] ?? '',
      path: json['path'] ?? '',
      url: json['url'] ?? '',
      fileType: json['fileType'] ?? '',
      mimeType: json['mimeType'] ?? '',
      size: json['size'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
