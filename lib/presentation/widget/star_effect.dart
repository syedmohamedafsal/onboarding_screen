import 'dart:math';
import 'package:flutter/material.dart';

class StarBackground extends StatefulWidget {
  const StarBackground({super.key});

  @override
  State<StarBackground> createState() => _StarBackgroundState();
}

class _StarBackgroundState extends State<StarBackground>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  final List<Star> stars = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    /// Generate stars once
    for (int i = 0; i < 120; i++) {
      bool glow = random.nextBool();

      stars.add(
        Star(
          x: random.nextDouble(),
          y: random.nextDouble(),
          radius: random.nextDouble() * 2 + 1,
          phase: random.nextDouble() * 2 * pi,
          speed: random.nextDouble() * 1.5 + 0.5,
          glow: glow,
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: StarPainter(
            stars: stars,
            progress: controller.value,
          ),
        );
      },
    );
  }
}

class Star {
  final double x;
  final double y;
  final double radius;
  final double phase;
  final double speed;
  final bool glow;

  Star({
    required this.x,
    required this.y,
    required this.radius,
    required this.phase,
    required this.speed,
    required this.glow,
  });
}

class StarPainter extends CustomPainter {

  final List<Star> stars;
  final double progress;

  StarPainter({required this.stars, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {

    for (var star in stars) {

      double glowValue = 0.2;

      /// animate glowing stars
      if (star.glow) {
        glowValue =
            (sin((progress * star.speed * 2 * pi) + star.phase) + 1) / 2;
      }

      final paint = Paint()
        ..color = Colors.white.withOpacity(0.3 + glowValue * 0.7);

      final center = Offset(
        star.x * size.width,
        star.y * size.height,
      );

      final starPath = createStarPath(
        center,
        star.radius + glowValue * 2,
      );

      canvas.drawPath(starPath, paint);
    }
  }

  Path createStarPath(Offset center, double radius) {

    const int points = 5;
    final double innerRadius = radius / 2.5;

    Path path = Path();

    for (int i = 0; i < points * 2; i++) {

      double angle = (pi / points) * i;

      double r = i.isEven ? radius : innerRadius;

      double x = center.dx + r * cos(angle - pi / 2);
      double y = center.dy + r * sin(angle - pi / 2);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}