import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/colors.dart';

class SeparatorWedge extends StatelessWidget {
  final Color color;
  final double height;

  const SeparatorWedge({super.key, this.color = titleColor, this.height = 5.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Nutzt volle verfügbare Breite
      height: height,
      child: CustomPaint(painter: _SeparatorWedgePainter(color: color)),
    );
  }
}

class _SeparatorWedgePainter extends CustomPainter {
  final Color color;

  _SeparatorWedgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Start links oben
      ..lineTo(0, size.height) // Linke Kante
      ..lineTo(size.width, size.height * 0.5)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
