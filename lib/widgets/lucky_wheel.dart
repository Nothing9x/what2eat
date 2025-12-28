import 'dart:math';
import 'package:flutter/material.dart';
import '../models/food_item.dart';

class LuckyWheel extends StatelessWidget {
  final AnimationController controller;
  final bool isSpinning;
  final List<FoodItem> items;
  final double targetRotation;

  const LuckyWheel({
    super.key,
    required this.controller,
    required this.isSpinning,
    required this.items,
    this.targetRotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFFEC9213);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Use targetRotation if spinning, otherwise no rotation
        final rotation = controller.value * targetRotation;
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Wheel outer white container
            Container(
              width: 320,
              height: 320,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? const Color(0xFF2d2418) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: primaryColor.withOpacity(0.2),
                  width: 4,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor,
                    width: 4,
                  ),
                ),
                child: ClipOval(
                  child: Transform.rotate(
                    angle: rotation,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: isDark
                              ? [
                                  const Color(0xFF431407),
                                  const Color(0xFF7c2d12),
                                  const Color(0xFF431407),
                                  const Color(0xFF7c2d12),
                                  const Color(0xFF431407),
                                  const Color(0xFF7c2d12),
                                ]
                              : [
                                  const Color(0xFFffedd5),
                                  const Color(0xFFfed7aa),
                                  const Color(0xFFffedd5),
                                  const Color(0xFFfed7aa),
                                  const Color(0xFFffedd5),
                                  const Color(0xFFfed7aa),
                                ],
                          stops: const [0.0, 0.166, 0.333, 0.5, 0.666, 1.0],
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Divider lines between sections (positioned at the boundary)
                          CustomPaint(
                            size: const Size(304, 304),
                            painter: WheelDividerPainter(
                              sections: items.length,
                              color: isDark
                                  ? Colors.white.withOpacity(0.3)
                                  : Colors.black.withOpacity(0.15),
                            ),
                          ),
                          // Food items
                          ...List.generate(
                            items.length,
                            (index) {
                              final angle = (index * 2 * pi / items.length);
                              // Dynamic sizing based on item count
                              final fontSize = items.length <= 6 ? 32.0
                                  : items.length <= 8 ? 26.0
                                  : items.length <= 10 ? 22.0
                                  : 18.0;
                              final nameFontSize = items.length <= 6 ? 12.0
                                  : items.length <= 8 ? 10.0
                                  : items.length <= 10 ? 9.0
                                  : 8.0;
                              final topPadding = items.length <= 6 ? 35.0
                                  : items.length <= 8 ? 40.0
                                  : 45.0;

                              return Transform.rotate(
                                angle: angle,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: topPadding),
                                    child: Transform.rotate(
                                      angle: -rotation - angle,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            items[index].icon,
                                            style: TextStyle(fontSize: fontSize),
                                          ),
                                          SizedBox(height: items.length <= 6 ? 4 : 2),
                                          SizedBox(
                                            width: items.length <= 6 ? 60 : 50,
                                            child: Text(
                                              items[index].name,
                                              style: TextStyle(
                                                fontSize: nameFontSize,
                                                fontWeight: FontWeight.bold,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.grey[800],
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Red Triangle Pointer - positioned above the wheel
            Positioned(
              top: -24,
              child: CustomPaint(
                size: const Size(40, 40),
                painter: TrianglePainter(
                  color: const Color(0xFFD32F2F), // Red 700
                ),
              ),
            ),
            // Center Button
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? const Color(0xFF2d2418) : Colors.white,
                border: Border.all(
                  color: primaryColor,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WheelDividerPainter extends CustomPainter {
  final int sections;
  final Color color;

  WheelDividerPainter({required this.sections, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw radial lines from center to edge, positioned between sections
    for (int i = 0; i < sections; i++) {
      final angle = (i * 2 * pi / sections) - (pi / sections);
      final x = center.dx + radius * sin(angle);
      final y = center.dy - radius * cos(angle);

      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
