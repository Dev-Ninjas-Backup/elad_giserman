class CustomAppDetailsResponse {
  final int status;
  final String message;
  final CustomAppDetails data;

  CustomAppDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomAppDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CustomAppDetailsResponse(
      status: json['status'] ?? 200,
      message: json['message'] ?? '',
      data: CustomAppDetails.fromJson(json['data'] ?? {}),
    );
  }
}

class CustomAppDetails {
  final String id;
  final String title;
  final String description;
  final String logo;
  final String bannerCard;
  final String bannerPhoto;
  final String createAt;
  final String updatedAt;

  CustomAppDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.bannerCard,
    required this.bannerPhoto,
    required this.createAt,
    required this.updatedAt,
  });

  factory CustomAppDetails.fromJson(Map<String, dynamic> json) {
    return CustomAppDetails(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      bannerCard: json['bannerCard'] ?? '',
      bannerPhoto: json['bannerPhoto'] ?? '',
      createAt: json['createAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
