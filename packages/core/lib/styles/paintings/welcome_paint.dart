import 'package:core/core.dart';
import 'package:flutter/material.dart';

class WelcomePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final center = Offset(width / 2, height / 2);

    // Colors for the rings (bright gray, light gray)
    final List<Color> colors = [
      ColorX.instance.sc.grey750,
      ColorX.instance.sc.grey600,
      ColorX.instance.sc.grey500,
      ColorX.instance.sc.grey300,
    ];

    // Draw the four rings with specific colors
    for (var i = 0; i < 4; i++) {
      double radius =
          width * (1 / 3.3 - 0.05 * i); // Adjust spacing between rings
      Paint paint = Paint()
        ..color = colors[i % colors.length] // Use colors based on loop index
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
