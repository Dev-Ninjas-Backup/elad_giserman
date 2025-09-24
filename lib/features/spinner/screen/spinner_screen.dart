import 'dart:math' as math;
import 'package:elad_giserman/features/spinner/controller/spinner_controller.dart';
import 'package:elad_giserman/features/spinner/widget/wheel_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen>
    with SingleTickerProviderStateMixin {
  final SpinnerController controller = Get.put(SpinnerController());

  late AnimationController _animationController;
  late Animation<double> _animation;
  double _rotation = 0.0;
  final math.Random _rand = math.Random();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(() {
      setState(() => _rotation = _animation.value);
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final sel = _computeSelectedIndex();
        controller.setSelected(sel);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startSpin() {
    if (controller.isSpinning.value) return;
    controller.setSpinning(true);
    controller.selectedIndex.value = -1;

    final int fullSpins = 5 + _rand.nextInt(4);
    final double extra = _rand.nextDouble() * math.pi * 2;

    final double start = _rotation;
    final double target = start + fullSpins * 2 * math.pi + extra;

    final int ms = 3200 + fullSpins * 300;
    _animationController.duration = Duration(milliseconds: ms);

    _animation = Tween<double>(begin: start, end: target).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );

    _animationController.forward(from: 0.0);
  }

  int _computeSelectedIndex() {
    final items = controller.items;
    final int n = items.length;
    final double anglePer = 2 * math.pi / n;
    final double startAngle = -math.pi / 2;
    final double finalRotation = _rotation;

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

    _rotation = _rotation % (2 * math.pi);
    return bestIndex;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wheelSize = math.min(size.width, size.height) * 0.78;

    return Scaffold(
      appBar: AppBar(title: const Text('Spin Wheel'), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Obx(() {
            final sel = controller.selectedIndex.value;
            if (controller.isSpinning.value) {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Spinning...', style: TextStyle(fontSize: 18)),
              );
            }
            if (sel == -1) {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Tap SPIN to try your luck!',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🎯', style: TextStyle(fontSize: 26)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'You got',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.selectedText,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: SizedBox(
                width: wheelSize,
                height: wheelSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (_, __) {
                        return Transform.rotate(
                          angle: _rotation,
                          child: CustomPaint(
                            size: Size(wheelSize, wheelSize),
                            painter: WheelPainter(items: controller.items),
                          ),
                        );
                      },
                    ),
                    Container(
                      width: wheelSize * 0.28,
                      height: wheelSize * 0.28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.white, Color(0xFFEEF2FF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Obx(() {
                          final sel = controller.selectedIndex.value;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Result',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                sel == -1 ? '—' : controller.selectedText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 28,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Obx(() {
              final spinning = controller.isSpinning.value;
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: spinning ? null : _startSpin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    spinning ? 'Spinning...' : 'SPIN',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
