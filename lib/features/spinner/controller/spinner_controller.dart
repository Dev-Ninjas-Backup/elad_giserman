import 'dart:convert';
import 'dart:math' as math;
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/core/services/translation_service.dart';
import 'package:elad_giserman/features/spinner/model/spin_result_model.dart';
import 'package:elad_giserman/features/spinner/model/spin_table_model.dart';
import 'package:elad_giserman/features/spinner/service/spinner_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpinnerController extends GetxController
    with GetTickerProviderStateMixin {
  // Wheel slices are hardcoded (10% .. 100%).
  final items = <String>[
    '10% OFF',
    '20% OFF',
    '30% OFF',
    '40% OFF',
    '50% OFF',
    '60% OFF',
    '70% OFF',
    '80% OFF',
    '90% OFF',
    '100% OFF',
  ].obs;

  // For the painter API (kept generic), all slices have equal size.
  List<int> get equalSliceWeights => List<int>.filled(items.length, 1);

  late AnimationController animationController;
  late Animation<double> animation;
  final RxDouble rotation = 0.0.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxBool isSpinning = false.obs;
  final Rx<SpinResultData?> spinResult = Rx<SpinResultData?>(null);
  final RxBool isSubmitting = false.obs;
  final RxBool spinSuccessful = false.obs;
  final Rx<SpinTableResponse?> spinTable = Rx<SpinTableResponse?>(null);
  final RxBool isLoadingSpinTable = false.obs;
  final Rx<SpinTableItem?> selectedSpinItem = Rx<SpinTableItem?>(null);

  final RxList<SpinResultData> mySpinHistory = <SpinResultData>[].obs;
  final RxBool isLoadingMySpinHistory = false.obs;

  final math.Random _rand = math.Random();
  final SpinnerService _service = SpinnerService();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    animationController.addListener(() {
      if (!isClosed) {
        rotation.value = animation.value;
      }
    });
    animationController.addStatusListener((status) {
      if (!isClosed && status == AnimationStatus.completed) {
        final sel = _computeSelectedIndex();
        setSelected(sel);
      }
    });
    _fetchSpinTable();
  }

  void startSpin() {
    if (isSpinning.value) return;

    _startSpinInternal();
  }

  Future<void> _startSpinInternal() async {
    // Stop any existing animation
    if (animationController.isAnimating) {
      animationController.stop();
    }

    isSpinning.value = true;
    selectedIndex.value = -1;
    spinSuccessful.value = false;
    selectedSpinItem.value = null;

    try {
      // Fetch latest spin data on each spin so the API can control the outcome.
      final response = await _service.fetchSpinTable();
      if (isClosed) return;

      if (response == null || response.data.isEmpty) {
        isSpinning.value = false;
        _translateAndShowError(
          'error'.tr,
          'Spin data not available. Please try again.',
        );
        return;
      }

      spinTable.value = response;
      final spinData = response.data;

      // Select using API-provided probabilities.
      final int pickedIndex = await _getWeightedRandomIndexFrom(spinData);
      final SpinTableItem picked =
          spinData[pickedIndex.clamp(0, spinData.length - 1)];

      selectedSpinItem.value = picked;

      if (kDebugMode) {
        print(
          '🎯 API picked: index=$pickedIndex value=${picked.spinValue1} prob=${picked.probablity}',
        );
      }

      final int spinValue = picked.spinValue1;
      final int uiIndex = _mapSpinValueToUiIndex(spinValue);

      if (kDebugMode) {
        print(
          '🎯 spinValue1: $spinValue → UI index: $uiIndex (${items[uiIndex]})',
        );
      }

      final double start = rotation.value % (2 * math.pi);
      double desired = _rotationForUiIndex(uiIndex);
      if (desired < start) {
        desired += 2 * math.pi;
      }

      final int fullSpins = 5 + _rand.nextInt(4);
      final double target = desired + fullSpins * 2 * math.pi;

      final int ms = 3200 + fullSpins * 300;
      animationController.duration = Duration(milliseconds: ms);

      animation = Tween<double>(begin: start, end: target).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate),
      );

      await animationController.forward(from: 0.0);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error starting spin: $e');
      }
      if (!isClosed) {
        isSpinning.value = false;
        _translateAndShowError(
          'error'.tr,
          'Unable to spin right now. Please try again.',
        );
      }
    }
  }

  int _mapSpinValueToUiIndex(int spinValue) {
    // The UI wheel is 10 fixed slices: 10,20,30,...,100.
    final int clamped = spinValue.clamp(10, 100);
    final int roundedToTens = ((clamped / 10).round()) * 10;
    return ((roundedToTens ~/ 10) - 1).clamp(0, items.length - 1);
  }

  double _rotationForUiIndex(int index) {
    // Must match _computeSelectedIndex() geometry:
    // - Wheel slices start at -pi/2
    // - Pointer is at top (-pi/2) -> 90 degrees.
    // Align the CENTER of slice `index` to the pointer.
    final int n = items.length;
    final double anglePer = 2 * math.pi / n;
    final double startAngle = -math.pi / 2;
    final double topAngle = -math.pi / 2;
    final double centerAngle = startAngle + index * anglePer + anglePer / 2;
    return (topAngle - centerAngle) % (2 * math.pi);
  }

  Future<int> _getWeightedRandomIndexFrom(List<SpinTableItem> spinData) async {
    if (spinData.isEmpty) return 0;

    final totalProbability = spinData.fold(
      0,
      (sum, item) => sum + item.probablity,
    );
    if (totalProbability <= 0) return 0;
    final int randomValue = _rand.nextInt(totalProbability);

    int cumulativeProbability = 0;
    for (int i = 0; i < spinData.length; i++) {
      cumulativeProbability += spinData[i].probablity;
      if (randomValue < cumulativeProbability) {
        return i;
      }
    }
    return 0;
  }

  void setSelected(int index) {
    selectedIndex.value = index;
    isSpinning.value = false;

    final selectedItem = selectedSpinItem.value;
    if (selectedItem != null && kDebugMode) {
      print('🎁 Spin result selected: ${selectedItem.useCase}');
      print('   Discount: ${selectedItem.spinValue1}%');
      print('   Probability: ${selectedItem.probablity}%');
    }

    // Submit spin result to API
    _submitSpinResult(selectedSpinItem.value?.id);
  }

  Future<void> _submitSpinResult(String? spinId) async {
    // Check if user is logged in
    final token = await SharedPreferencesHelper.getAccessToken();
    if (token == null || token.isEmpty) {
      if (kDebugMode) {
        print("❌ User not logged in");
      }
      if (!isClosed) {
        _translateAndShowError(
          'error'.tr,
          "Please login to save your spin result",
        );
      }
      return;
    }

    if (spinId == null || spinId.isEmpty) {
      if (!isClosed) {
        _translateAndShowError('error'.tr, "Spin id not available");
      }
      return;
    }

    if (!isClosed) {
      isSubmitting.value = true;
    }
    try {
      if (kDebugMode) {
        print("🎬 Starting to submit spin history with id: $spinId");
      }

      final response = await _service.submitSpinHistory(spinId: spinId);

      if (isClosed) return;

      if (kDebugMode) {
        print("📊 Response received with status: ${response.statusCode}");
        print("📊 Response body: ${response.body}");
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("✅ Spin result submitted successfully: ${response.statusCode}");
          print("✅ Response data: ${jsonResponse.toString()}");
        }

        // Parse and store the spin result
        if (jsonResponse['data'] != null) {
          spinResult.value = SpinResultData.fromJson(jsonResponse['data']);
          spinSuccessful.value = true; // Mark as successful
          if (kDebugMode) {
            print("✅ Spin result saved: ${spinResult.value?.id}");
          }
        } else {
          if (kDebugMode) {
            print("⚠️ Response data is null");
          }
          spinSuccessful.value = false;
        }
      } else {
        if (kDebugMode) {
          print("❌ Failed to submit spin result: ${response.statusCode}");
          print("❌ Response body: ${response.body}");
        }

        spinSuccessful.value = false; // Mark as failed

        // Try to parse error message from response
        String errorMessage = "Failed to save spin result";
        try {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['message'] != null) {
            errorMessage = jsonResponse['message'];
          } else if (jsonResponse['data'] != null &&
              jsonResponse['data']['message'] != null) {
            errorMessage = jsonResponse['data']['message'];
          }
        } catch (e) {
          if (kDebugMode) {
            print("⚠️ Could not parse error message: $e");
          }
        }

        if (!isClosed) {
          _translateAndShowError("Unable to Save Spin", errorMessage);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error submitting spin result: $e");
        print("❌ Stack trace: ${StackTrace.current}");
      }
      spinSuccessful.value = false; // Mark as failed
      if (!isClosed) {
        Get.snackbar(
          "Error",
          "Network error. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      if (!isClosed) {
        isSubmitting.value = false;
      }
    }
  }

  Future<void> fetchMySpinHistory() async {
    final token = await SharedPreferencesHelper.getAccessToken();
    if (token == null || token.isEmpty) {
      return;
    }

    try {
      isLoadingMySpinHistory.value = true;
      final response = await _service.fetchMySpinHistory();
      if (response != null) {
        mySpinHistory.assignAll(response.data);
      }
    } finally {
      isLoadingMySpinHistory.value = false;
    }
  }

  String get selectedText =>
      (selectedIndex.value >= 0 && selectedIndex.value < items.length)
      ? items[selectedIndex.value]
      : '';

  int _computeSelectedIndex() {
    final n = items.length;
    final double anglePer = 2 * math.pi / n;
    final double startAngle = -math.pi / 2;
    final double finalRotation = rotation.value;

    double bestDiff = double.infinity;
    int bestIndex = 0;
    final double topAngle = (-math.pi / 2) % (2 * math.pi);

    for (int k = 0; k < n; k++) {
      final double centerAngle = startAngle + k * anglePer + anglePer / 2;
      final double finalCenter = (centerAngle + finalRotation) % (2 * math.pi);
      final double diffClockwise = (finalCenter - topAngle) % (2 * math.pi);
      final double diffAnticlock = (topAngle - finalCenter) % (2 * math.pi);
      final double diff = math.min(diffClockwise, diffAnticlock);
      if (diff < bestDiff) {
        bestDiff = diff;
        bestIndex = k;
      }
    }

    rotation.value = rotation.value % (2 * math.pi);
    return bestIndex;
  }

  Future<void> _fetchSpinTable() async {
    try {
      if (kDebugMode) {
        print('🎡 Fetching spin table data...');
      }
      isLoadingSpinTable.value = true;

      final response = await _service.fetchSpinTable();

      if (response != null && response.data.isNotEmpty) {
        spinTable.value = response;
        if (kDebugMode) {
          print('✅ Spin table loaded: ${response.data.length} items');
        }
      } else {
        if (kDebugMode) {
          print('⚠️ No spin table data available');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching spin table: $e');
      }
    } finally {
      isLoadingSpinTable.value = false;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  Future<void> _translateAndShowError(String title, String message) async {
    final currentLanguage = Get.locale?.languageCode ?? 'en';

    String translatedTitle = title;
    String translatedMessage = message;

    if (currentLanguage != 'en') {
      try {
        translatedTitle = await _translateText(title, currentLanguage);
        translatedMessage = await _translateText(message, currentLanguage);
      } catch (e) {
        if (kDebugMode) {
          print("⚠️ Translation failed: $e");
        }
      }
    }

    Get.snackbar(
      translatedTitle,
      translatedMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: Duration(seconds: 4),
    );
  }

  Future<String> _translateText(String text, String targetLanguage) async {
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
