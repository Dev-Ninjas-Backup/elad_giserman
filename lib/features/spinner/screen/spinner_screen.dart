import 'dart:math' as math;
import 'package:elad_giserman/core/utils/constants/colors.dart';
import 'package:elad_giserman/core/utils/constants/icon_path.dart';
import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:elad_giserman/features/spinner/controller/spinner_controller.dart';
import 'package:elad_giserman/features/spinner/widget/result_dialog.dart';
import 'package:elad_giserman/features/spinner/widget/wheel_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpinnerScreen extends StatelessWidget {
  const SpinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SpinnerController controller = Get.put(SpinnerController());
    final size = MediaQuery.of(context).size;
    final wheelSize = math.min(size.width, size.height) * 0.78;

    ever(controller.selectedIndex, (index) {
      if (index != -1) {
        Get.dialog(
          ResultDialog(result: controller.selectedText),
          barrierDismissible: false,
        );
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.spinBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 90),
            Obx(() {
              if (controller.isSpinning.value) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Spinning...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Tap SPIN to try your luck!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
                            painter: WheelPainter(items: controller.items),
                          ),
                        );
                      }),
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
                          child: Image.asset(
                            IconPath.appIcon,
                            height: 80,
                            width: 80,
                          ),
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
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Obx(() {
                final spinning = controller.isSpinning.value;
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: spinning ? null : controller.startSpin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      spinning ? 'Spinning...' : 'SPIN',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
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
      ),
    );
  }
}
