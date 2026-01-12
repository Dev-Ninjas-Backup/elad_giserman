import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/core/services/translation_service.dart';
import 'package:elad_giserman/features/spinner/model/spin_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SpinHistoryScreen extends StatefulWidget {
  const SpinHistoryScreen({super.key});

  @override
  State<SpinHistoryScreen> createState() => _SpinHistoryScreenState();
}

class _SpinHistoryScreenState extends State<SpinHistoryScreen> {
  late RxList<SpinHistoryItem> spinHistory;
  late RxBool isLoading;

  @override
  void initState() {
    super.initState();
    spinHistory = <SpinHistoryItem>[].obs;
    isLoading = false.obs;
    _fetchSpinHistory();
  }

  Future<void> _fetchSpinHistory() async {
    try {
      isLoading.value = true;

      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        Get.snackbar(
          'error'.tr,
          'login_required'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final response = await http.get(
        Uri.parse(Urls.mySpinHistory),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final historyResponse = SpinHistoryResponse.fromJson(jsonResponse);
        spinHistory.assignAll(historyResponse.data);
      } else {
        Get.snackbar(
          'error'.tr,
          'failed_to_fetch_spin_history'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        '${'error'.tr}: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('spin_history'.tr, style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        }

        if (spinHistory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 80, color: Colors.grey.shade400),
                SizedBox(height: 16),
                Text(
                  'no_spin_history'.tr,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: spinHistory.length,
          itemBuilder: (context, index) {
            final item = spinHistory[index];
            return _buildSpinHistoryCard(item);
          },
        );
      }),
    );
  }

  Widget _buildSpinHistoryCard(SpinHistoryItem item) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final formattedDate = dateFormat.format(item.createdAt);
    final translatedUseCase = _getTranslatedUseCase(item.spin.useCase);

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      color: Colors.white,
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber.shade200, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: Colors.amber.shade700,
                  size: 32,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.spin.spinValue1}% ${'discount'.tr}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: item.isUsed
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.isUsed ? 'used'.tr : 'unused'.tr,
                    style: TextStyle(
                      color: item.isUsed
                          ? Colors.red.shade700
                          : Colors.green.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => Text(
                  translatedUseCase.value,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 13),
                ),
              ),
            ),
            if (item.spin.expireAt != null) ...[
              SizedBox(height: 8),
              Text(
                '${'expires'.tr} ${dateFormat.format(item.spin.expireAt!)}',
                style: TextStyle(color: Colors.orange.shade600, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Rx<String> _getTranslatedUseCase(String useCase) {
    final currentLanguage = Get.locale?.languageCode ?? 'en';
    final result = useCase.obs;

    if (currentLanguage != 'en') {
      _translateUseCase(useCase, currentLanguage).then((translated) {
        result.value = translated;
      });
    }

    return result;
  }

  Future<String> _translateUseCase(String text, String targetLanguage) async {
    try {
      final translationService = Get.find<TranslationService>();
      return await translationService.translateText(
        text: text,
        targetLanguage: targetLanguage,
        sourceLanguage: 'en',
      );
    } catch (e) {
      return text;
    }
  }
}
