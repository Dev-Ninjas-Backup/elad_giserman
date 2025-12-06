class SpinResultData {
  final String id;
  final String userId;
  final int result;
  final bool isUsed;
  final String createdAt;
  final String updatedAt;

  SpinResultData({
    required this.id,
    required this.userId,
    required this.result,
    required this.isUsed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpinResultData.fromJson(Map<String, dynamic> json) {
    return SpinResultData(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      result: json['result'] ?? 0,
      isUsed: json['isUsed'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'result': result,
      'isUsed': isUsed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
