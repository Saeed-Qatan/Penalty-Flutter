import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search, color: Colors.white54, size: 24),
            const SizedBox(width: 12),
            const Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'ابحث عن ملعب كرة قدم...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white54,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
