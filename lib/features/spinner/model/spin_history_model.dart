class SpinHistoryResponse {
  final int status;
  final String message;
  final List<SpinHistoryItem> data;

  SpinHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SpinHistoryResponse.fromJson(Map<String, dynamic> json) {
    return SpinHistoryResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => SpinHistoryItem.fromJson(item))
          .toList(),
    );
  }
}

class SpinHistoryItem {
  final String id;
  final String userId;
  final String spinId;
  final bool isUsed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SpinData spin;

  SpinHistoryItem({
    required this.id,
    required this.userId,
    required this.spinId,
    required this.isUsed,
    required this.createdAt,
    required this.updatedAt,
    required this.spin,
  });

  factory SpinHistoryItem.fromJson(Map<String, dynamic> json) {
    return SpinHistoryItem(
      id: json['id'],
      userId: json['userId'],
      spinId: json['spinId'],
      isUsed: json['isUsed'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      spin: SpinData.fromJson(json['spin']),
    );
  }
}

class SpinData {
  final String id;
  final int spinValue1;
  final int probablity;
  final String useCase;
  final DateTime? expireAt;
  final String? restName;
  final DateTime createdAt;
  final DateTime updatedAt;

  SpinData({
    required this.id,
    required this.spinValue1,
    required this.probablity,
    required this.useCase,
    this.expireAt,
    this.restName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpinData.fromJson(Map<String, dynamic> json) {
    return SpinData(
      id: json['id'],
      spinValue1: json['spinValue1'],
      probablity: json['probablity'],
      useCase: json['useCase'],
      expireAt: json['expireAt'] != null
          ? DateTime.parse(json['expireAt'])
          : null,
      restName: json['restName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
