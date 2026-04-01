import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Animated pulsing rings that expand outward from the center,
/// replicating the CSS `pulse-ring` keyframe animation.
class PulseRings extends StatefulWidget {
  const PulseRings({super.key});

  @override
  State<PulseRings> createState() => _PulseRingsState();
}

class _PulseRingsState extends State<PulseRings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: List.generate(3, (index) {
            final double delay = index * 0.333;
            double progress = (_controller.value + delay) % 1.0;
            return _buildRing(progress);
          }),
        );
      },
    );
  }

  Widget _buildRing(double progress) {
    // 0% → 60px, opacity 0
    // 50% → opacity 0.5
    // 100% → 250px, opacity 0
    final double size = 60 + (190 * progress);

    double opacity;
    if (progress < 0.5) {
      opacity = progress;
    } else {
      opacity = 1.0 - progress;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.neonGreen.withValues(alpha: opacity * 0.4),
      ),
    );
  }
}
