import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      // Support navigating to the initial location when tapping the item that is already active
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 24, left: 24, right: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF121212).withValues(alpha: 0.95),
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildNavItem(
                context,
                index: 0,
                iconPath: Icons.home_filled,
                unselectedIconPath: Icons.home_outlined,
                label: 'الرئيسية',
              ),
              _buildNavItem(
                context,
                index: 1,
                iconPath: Icons.search,
                unselectedIconPath: Icons.search,
                label: 'بحث',
              ),
              _buildNavItem(
                context,
                index: 2,
                iconPath: Icons.calendar_month,
                unselectedIconPath: Icons.calendar_month_outlined,
                label: 'حجوزاتي',
              ),
              _buildNavItem(
                context,
                index: 3,
                iconPath: Icons.person,
                unselectedIconPath: Icons.person_outline,
                label: 'الملف الشخصي',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData iconPath,
    required IconData unselectedIconPath,
    required String label,
  }) {
    final isSelected = navigationShell.currentIndex == index;
    final color = isSelected ? AppColors.neonGreen : Colors.white.withValues(alpha: 0.4);

    return GestureDetector(
      onTap: () => _onTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(0, isSelected ? -4 : 0, 0),
                child: Icon(
                  isSelected ? iconPath : unselectedIconPath,
                  color: color,
                  size: 28,
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: -8,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.neonGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
