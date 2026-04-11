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

class OwnerInfo {
  final String name;

  OwnerInfo({required this.name});

  factory OwnerInfo.fromJson(Map<String, dynamic> json) {
    return OwnerInfo(name: json['name'] ?? '');
  }
}

class ProfileCategory {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  ProfileCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileCategory.fromJson(Map<String, dynamic> json) {
    return ProfileCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class BusinessProfile {
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
  final ProfileCategory category;
  final List<GalleryItem> gallery;
  final OwnerInfo owner;
  final int totalOffers;
  final int totalRedemptions;
  final int reviewCount;
  final double? avgRating;

  BusinessProfile({
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
    required this.category,
    required this.gallery,
    required this.owner,
    required this.totalOffers,
    required this.totalRedemptions,
    required this.reviewCount,
    this.avgRating,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      isActive: json['isActive'] ?? false,
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      categoryId: json['categoryId'] ?? (json['category']?['id'] ?? ''),
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
      category: ProfileCategory.fromJson(json['category'] ?? {}),
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map(
                (item) => GalleryItem.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      owner: OwnerInfo.fromJson(json['owner'] ?? {}),
      totalOffers: json['totalOffers'] ?? 0,
      totalRedemptions: json['totalRedemptions'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      avgRating: json['avgRating'] is num
          ? (json['avgRating'] as num).toDouble()
          : null,
    );
  }
}
