class NotificationResponse {
  final int status;
  final String message;
  final NotificationData data;

  NotificationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: NotificationData.fromJson(json['data'] ?? {}),
    );
  }
}

class NotificationData {
  final int unreadCount;
  final List<NotificationItem> today;
  final List<NotificationItem> previous;

  NotificationData({
    required this.unreadCount,
    required this.today,
    required this.previous,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      unreadCount: json['unreadCount'] ?? 0,
      today: (json['today'] as List?)
              ?.map((item) => NotificationItem.fromJson(item))
              .toList() ??
          [],
      previous: (json['yesterday'] as List?)
              ?.map((item) => NotificationItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class NotificationItem {
  final String id;
  final String userId;
  final String notificationId;
  final bool read;
  final String createdAt;
  final String updatedAt;
  final Notification notification;

  NotificationItem({
    required this.id,
    required this.userId,
    required this.notificationId,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
    required this.notification,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      notificationId: json['notificationId'] ?? '',
      read: json['read'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      notification: Notification.fromJson(json['notification'] ?? {}),
    );
  }
}

class Notification {
  final String id;
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic> meta;
  final String createdAt;
  final String updatedAt;

  Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      meta: json['meta'] ?? {},
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
