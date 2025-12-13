class ReservationResponse {
  final int statusCode;
  final String message;
  final ReservationData data;

  ReservationResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ReservationResponse.fromJson(Map<String, dynamic> json) {
    return ReservationResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: ReservationData.fromJson(json['data'] ?? {}),
    );
  }
}

class ReservationData {
  final List<Reservation> lastWeek;
  final List<Reservation> thisWeek;

  ReservationData({required this.lastWeek, required this.thisWeek});

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      lastWeek:
          (json['lastWeek'] as List<dynamic>?)
              ?.map(
                (item) => Reservation.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      thisWeek:
          (json['thisWeek'] as List<dynamic>?)
              ?.map(
                (item) => Reservation.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class Reservation {
  final String id;
  final String userId;
  final String restaurantId;
  final String date;
  final String time;
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;
  final bool isActive;
  final bool approval;
  final Restaurant restaurant;

  Reservation({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.date,
    required this.time,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.approval,
    required this.restaurant,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      restaurantId:
          json['restaurntId'] ?? '', // Note: API has typo 'restaurntId'
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      isActive: json['isActive'] ?? false,
      approval: json['aproval'] ?? false, // Note: API has typo 'aproval'
      restaurant: Restaurant.fromJson(json['restaurant'] ?? {}),
    );
  }
}

class Restaurant {
  final String id;
  final String title;
  final List<String> gallery;

  Restaurant({required this.id, required this.title, required this.gallery});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map((item) {
                if (item is Map<String, dynamic>) {
                  return item['url'] as String? ?? '';
                }
                return item as String? ?? '';
              })
              .where((url) => url.isNotEmpty)
              .toList() ??
          [],
    );
  }
}
