import 'dart:math' as math;
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

  final math.Random _rand = math.Random();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    animationController.addListener(() {
      rotation.value = animation.value;
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final sel = _computeSelectedIndex();
        setSelected(sel);
      }
    });
  }

  void startSpin() {
    if (isSpinning.value) return;
    isSpinning.value = true;
    selectedIndex.value = -1;

    final int fullSpins = 5 + _rand.nextInt(4);
    final double extra = _rand.nextDouble() * math.pi * 2;

    final double start = rotation.value;
    final double target = start + fullSpins * 2 * math.pi + extra;

    final int ms = 3200 + fullSpins * 300;
    animationController.duration = Duration(milliseconds: ms);

    animation = Tween<double>(begin: start, end: target).animate(
      CurvedAnimation(parent: animationController, curve: Curves.decelerate),
    );

    animationController.forward(from: 0.0);
  }

  void setSelected(int index) {
    selectedIndex.value = index;
    isSpinning.value = false;

    Future.delayed(Duration(milliseconds: 300), () {
      selectedIndex.value = -1;
    });
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
}
