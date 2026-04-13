// ignore_for_file: unnecessary_cast

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
  final String userName;
  final String avatarUrl;
  final String businessId;
  final String createdAt;
  final String updatedAt;
  final List<ReviewReply> replies;

  Review({
    required this.id,
    required this.comment,
    required this.rating,
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    this.replies = const [],
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    // Extract user name and avatarUrl from nested user object
    final userMap = json['user'] as Map<String, dynamic>?;
    final userName = userMap?['name'] as String? ?? '';
    final avatarUrl = userMap?['avatarUrl'] as String? ?? '';
    
    return Review(
      id: json['id'] ?? '',
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      userId: json['userId'] ?? '',
      userName: userName,
      avatarUrl: avatarUrl,
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
  final String phone;
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
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.gallery,
    required this.offers,
    required this.reviews,
    this.rating,
    this.reviewCount = 0,
  });

  factory BusinessProfileDetail.fromJson(Map<String, dynamic> json) {
    // Recursive search for numeric values whose keys contain certain keywords.
    double? findNumericByKeySubstring(dynamic node, String substring) {
      if (node is Map<String, dynamic>) {
        for (final entry in node.entries) {
          final key = entry.key.toLowerCase();
          final value = entry.value;
          if (key.contains(substring) && value is num) return (value as num).toDouble();
        }
        for (final entry in node.entries) {
          final result = findNumericByKeySubstring(entry.value, substring);
          if (result != null) return result;
        }
      } else if (node is List) {
        for (final item in node) {
          final result = findNumericByKeySubstring(item, substring);
          if (result != null) return result;
        }
      }
      return null;
    }

    int findIntByKeySubstrings(dynamic node, List<String> substrings) {
      if (node is Map<String, dynamic>) {
        for (final entry in node.entries) {
          final key = entry.key.toLowerCase();
          final value = entry.value;
          bool matches = true;
          for (final s in substrings) {
            if (!key.contains(s)) {
              matches = false;
              break;
            }
          }
          if (matches && value is num) return (value as num).toInt();
        }
        for (final entry in node.entries) {
          final result = findIntByKeySubstrings(entry.value, substrings);
          if (result != -1) return result;
        }
      } else if (node is List) {
        for (final item in node) {
          final result = findIntByKeySubstrings(item, substrings);
          if (result != -1) return result;
        }
      }
      return -1;
    }

    final parsedReviews = (json['reviews'] as List<dynamic>?)
            ?.map((item) => Review.fromJson(item as Map<String, dynamic>))
            .toList() ??
        [];

    // Prefer explicit rating keys, then search recursively for any 'rating' key.
    double? ratingVal;
    if (json['rating'] is num) {
      ratingVal = (json['rating'] as num).toDouble();
    } else if (json['avgRating'] is num) {
      ratingVal = (json['avgRating'] as num).toDouble();
    } else if (json['avg_rating'] is num) {
      ratingVal = (json['avg_rating'] as num).toDouble();
    } else {
      ratingVal = findNumericByKeySubstring(json, 'rating');
    }

    // For review count, try common keys, then recursive search, then fallback to reviews length.
    int reviewCountVal = 0;
    if (json['reviewCount'] is num) {
      reviewCountVal = (json['reviewCount'] as num).toInt();
    } else if (json['reviewsCount'] is num) {
      reviewCountVal = (json['reviewsCount'] as num).toInt();
    } else if (json['reviews_count'] is num) {
      reviewCountVal = (json['reviews_count'] as num).toInt();
    } else if (json['review_count'] is num) {
      reviewCountVal = (json['review_count'] as num).toInt();
    } else {
      final found = findIntByKeySubstrings(json, ['review', 'count']);
      if (found != -1) {
        reviewCountVal = found;
      } else {
        reviewCountVal = parsedReviews.length;
      }
    }

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
      phone: json['phone'] ?? '',
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
          rating: ratingVal,
          reviewCount: reviewCountVal,
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
