class SpinTableResponse {
  final int status;
  final String message;
  final List<SpinTableItem> data;

  SpinTableResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SpinTableResponse.fromJson(Map<String, dynamic> json) {
    final dynamic rawData = json['data'];
    final List<SpinTableItem> parsedData;

    if (rawData is List) {
      parsedData = rawData
          .whereType<Map<String, dynamic>>()
          .map(SpinTableItem.fromJson)
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      // Some API responses return a single object in `data`.
      parsedData = [SpinTableItem.fromJson(rawData)];
    } else {
      parsedData = [];
    }

    return SpinTableResponse(
      status: json['status'] ?? 200,
      message: json['message'] ?? '',
      data: parsedData,
    );
  }
}

class SpinTableItem {
  final String id;
  final int spinValue1;
  final int probablity;
  final String useCase;
  final String? expireAt;
  final String? restName;
  final String createdAt;
  final String updatedAt;

  SpinTableItem({
    required this.id,
    required this.spinValue1,
    required this.probablity,
    required this.useCase,
    this.expireAt,
    this.restName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpinTableItem.fromJson(Map<String, dynamic> json) {
    return SpinTableItem(
      id: json['id'] ?? '',
      spinValue1: json['spinValue1'] ?? 0,
      probablity: json['probablity'] ?? 0,
      useCase: json['useCase'] ?? '',
      expireAt: json['expireAt'],
      restName: json['restName'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
