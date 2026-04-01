import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// A reusable pulsing icon widget with concentric animated rings.
/// Replicates the animate-pulse effect with neon green borders.
class PulsingIcon extends StatefulWidget {
  final IconData icon;
  final double iconSize;
  final double containerSize;

  const PulsingIcon({
    super.key,
    required this.icon,
    this.iconSize = 80,
    this.containerSize = 280,
  });

  @override
  State<PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.containerSize,
      height: widget.containerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulsing ring
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                width: 200 * _pulseAnimation.value,
                height: 200 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.neonGreen.withValues(alpha: 0.10),
                    width: 2,
                  ),
                ),
              );
            },
          ),
          // Inner static ring
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.neonGreen.withValues(alpha: 0.20),
                width: 1,
              ),
            ),
          ),
          // Dark surface card with icon
          Container(
            width: widget.containerSize,
            height: widget.containerSize,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000), // rgba(0,0,0,0.2)
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: AppColors.neonGreen,
                ),
                // Animated ring overlay inside the card
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 200 * _pulseAnimation.value,
                      height: 200 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.neonGreen
                              .withValues(alpha: 0.10 * _pulseAnimation.value),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.neonGreen.withValues(alpha: 0.20),
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
