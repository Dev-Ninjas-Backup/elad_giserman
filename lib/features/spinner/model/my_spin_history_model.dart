import 'package:elad_giserman/features/spinner/model/spin_result_model.dart';

class MySpinHistoryResponse {
  final int status;
  final String message;
  final List<SpinResultData> data;

  MySpinHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MySpinHistoryResponse.fromJson(Map<String, dynamic> json) {
    final dynamic rawData = json['data'];
    final List<SpinResultData> parsed;

    if (rawData is List) {
      parsed = rawData
          .whereType<Map<String, dynamic>>()
          .map(SpinResultData.fromJson)
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      parsed = [SpinResultData.fromJson(rawData)];
    } else {
      parsed = [];
    }

    return MySpinHistoryResponse(
      status: json['status'] ?? 200,
      message: json['message'] ?? '',
      data: parsed,
    );
  }
}
