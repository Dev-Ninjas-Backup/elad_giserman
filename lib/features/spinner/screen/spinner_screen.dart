import 'dart:math' as math;
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/spinner/controller/spinner_controller.dart';
import 'package:elad_giserman/features/spinner/widget/result_dialog.dart';
import 'package:elad_giserman/features/spinner/widget/wheel_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  late SpinnerController controller;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    // Use getOrPut to avoid creating duplicate controllers
    if (Get.isRegistered<SpinnerController>()) {
      controller = Get.find<SpinnerController>();
    } else {
      controller = Get.put(SpinnerController());
    }
    
    // Set up listener only once when widget is first created
    ever(controller.selectedIndex, (index) {
      if (index != -1 && !_dialogShown && controller.spinSuccessful.value) {
        _dialogShown = true;
        Future.delayed(Duration.zero, () {
          if (mounted) {
            Get.dialog(
              ResultDialog(result: controller.selectedText),
              barrierDismissible: false,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _dialogShown = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wheelSize = math.min(size.width, size.height) * 0.78;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade900, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              image: DecorationImage(
                image: AssetImage(ImagePath.spinBackground),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 90),
                    Obx(() {
                      if (controller.isSpinning.value) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Spinning...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                              letterSpacing: 1.2,
                            ),
                          ),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Tap SPIN to try your luck!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      );
                    }),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: wheelSize,
                          height: wheelSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                return Transform.rotate(
                                  angle: controller.rotation.value,
                                  child: CustomPaint(
                                    size: Size(wheelSize, wheelSize),
                                    painter: WheelPainter(
                                      items: controller.items,
                                    ),
                                  ),
                                );
                              }),
                              Container(
                                width: wheelSize * 0.28,
                                height: wheelSize * 0.28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFD700),
                                      Color(0xFFFFA500),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.amber.withOpacity(0.6),
                                      blurRadius: 20,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    IconPath.spinIcon,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: Obx(() {
                        final spinning = controller.isSpinning.value;
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: spinning ? null : controller.startSpin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              padding: EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              // ignore: deprecated_member_use
                              shadowColor: Colors.black.withOpacity(0.3),
                              elevation: 8,
                            ),
                            child: Text(
                              spinning ? 'Spinning...' : 'SPIN',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height > 700 ? 250 : 100,
            child: Image.asset(
              IconPath.whilePointer,
              height: MediaQuery.of(context).size.height > 700 ? 150 : 120,
              width: MediaQuery.of(context).size.height > 700 ? 150 : 120,
            ),
          ),
        ],
      ),
    );
  }
}
