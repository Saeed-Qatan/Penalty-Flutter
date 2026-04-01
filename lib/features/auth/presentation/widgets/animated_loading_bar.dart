import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AnimatedLoadingBar extends StatefulWidget {
  const AnimatedLoadingBar({super.key});

  @override
  State<AnimatedLoadingBar> createState() => _AnimatedLoadingBarState();
}

class _AnimatedLoadingBarState extends State<AnimatedLoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
    return Container(
      width: 120,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(1.5),
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                // Loop simulation logic similar to CSS animation progress
                width: 120 * _animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
