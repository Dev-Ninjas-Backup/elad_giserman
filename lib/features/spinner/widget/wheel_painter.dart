import 'dart:math' as math;
import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  final List<String> items;
  WheelPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final int n = items.length;
    final double angle = 2 * math.pi / n;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2;

    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final List<Color> colors = List.generate(n, (i) {
      final double hue = (i * 360 / n);
      return HSLColor.fromAHSL(1.0, hue, 0.72, 0.52).toColor();
    });

    for (int i = 0; i < n; i++) {
      final double start = -math.pi / 2 + i * angle;
      paint.shader = LinearGradient(
        // ignore: deprecated_member_use
        colors: [colors[i], Colors.black.withOpacity(0.2)], // changed
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

      canvas.drawArc(rect, start, angle, true, paint);

      final String label = items[i];
      final double labelAngle = start + angle / 2;
      final double textRadius = radius * 0.62;
      final Offset textPos = Offset(
        center.dx + textRadius * math.cos(labelAngle),
        center.dy + textRadius * math.sin(labelAngle),
      );

      final TextSpan span = TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 2),
          ],
        ),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: radius * 0.8);

      canvas.save();
      canvas.translate(textPos.dx, textPos.dy);

      double rotation = labelAngle;
      if (rotation > math.pi / 2 && rotation < 3 * math.pi / 2) {
        rotation += math.pi;
      }
      canvas.rotate(rotation);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
    final Paint innerPaint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.92, innerPaint);
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.items != items;
  }
}
