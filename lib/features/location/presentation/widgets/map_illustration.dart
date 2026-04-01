import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'pulse_rings.dart';

/// The location pin illustration with pulsing rings behind it.
class MapIllustration extends StatelessWidget {
  const MapIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dot grid pattern (decorative)
          Positioned.fill(
            child: Opacity(
              opacity: 0.20,
              child: CustomPaint(
                painter: _DotGridPainter(
                  dotColor: AppColors.neonGreen,
                  dotRadius: 1,
                  spacing: 24,
                ),
              ),
            ),
          ),

          // Pulsing rings
          const PulseRings(),

          // Center map pin icon
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonGreen.withValues(alpha: 0.15),
                  blurRadius: 40,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: const Icon(
              Icons.location_on,
              size: 64,
              color: AppColors.neonGreen,
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws a radial-masked dot grid similar to the CSS background-image pattern.
class _DotGridPainter extends CustomPainter {
  final Color dotColor;
  final double dotRadius;
  final double spacing;

  _DotGridPainter({
    required this.dotColor,
    required this.dotRadius,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        final point = Offset(x, y);
        final distance = (point - center).distance;
        final ratio = distance / maxRadius;
        if (ratio < 1.0) {
          paint.color = dotColor.withValues(alpha: (1.0 - ratio));
          canvas.drawCircle(point, dotRadius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
