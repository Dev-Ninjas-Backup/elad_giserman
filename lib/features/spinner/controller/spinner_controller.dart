import 'dart:convert';
import 'dart:math' as math;
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/spinner/model/spin_result_model.dart';
import 'package:elad_giserman/features/spinner/service/spinner_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpinnerController extends GetxController
    with GetTickerProviderStateMixin {
  final items = [
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

  late AnimationController animationController;
  late Animation<double> animation;
  final RxDouble rotation = 0.0.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxBool isSpinning = false.obs;
  final Rx<SpinResultData?> spinResult = Rx<SpinResultData?>(null);
  final RxBool isSubmitting = false.obs;
  final RxBool spinSuccessful = false.obs;

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
  }

  void startSpin() {
    if (isSpinning.value) return;

    // Stop any existing animation
    if (animationController.isAnimating) {
      animationController.stop();
    }

    isSpinning.value = true;
    selectedIndex.value = -1;
    spinSuccessful.value = false;

    final int fullSpins = 5 + _rand.nextInt(4);
    final double extra = _rand.nextDouble() * math.pi * 2;

    final double start = rotation.value % (2 * math.pi);
    final double target = start + fullSpins * 2 * math.pi + extra;

    final int ms = 3200 + fullSpins * 300;
    animationController.duration = Duration(milliseconds: ms);

    animation = Tween<double>(begin: start, end: target).animate(
      CurvedAnimation(parent: animationController, curve: Curves.decelerate),
    );

    animationController.forward(from: 0.0).catchError((error) {
      if (!isClosed) {
        isSpinning.value = false;
      }
    });
  }

  void setSelected(int index) {
    selectedIndex.value = index;
    isSpinning.value = false;

    // Submit spin result to API
    _submitSpinResult(index);
  }

  Future<void> _submitSpinResult(int resultIndex) async {
    // Check if user is logged in
    final token = await SharedPreferencesHelper.getAccessToken();
    if (token == null || token.isEmpty) {
      if (kDebugMode) {
        print("❌ User not logged in");
      }
      if (!isClosed) {
        Get.snackbar(
          "Error",
          "Please login to save your spin result",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return;
    }

    if (!isClosed) {
      isSubmitting.value = true;
    }
    try {
      if (kDebugMode) {
        print("🎬 Starting to submit spin result with index: $resultIndex");
      }

      final response = await _service.submitSpinResult(result: resultIndex);

      if (isClosed) return;

      if (kDebugMode) {
        print("📊 Response received with status: ${response.statusCode}");
        print("📊 Response body: ${response.body}");
      }

      if (response.statusCode == 201) {
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
          // Show success message
          Get.snackbar(
            "Success",
            "Spin result saved successfully!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
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

        Get.snackbar(
          "Unable to Save Spin",
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
        );
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

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
