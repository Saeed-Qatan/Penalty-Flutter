import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../widgets/pulsing_icon.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Content data for the 3 pages
    final pagesData = [
      {
        'icon': Icons.search,
        'title': LocaleKeys.onboardingTitle1.tr(),
        'subtitle': LocaleKeys.onboardingSubtitle1.tr(),
      },
      {
        'icon': Icons.sports_soccer, // Placeholder icon
        'title': LocaleKeys.onboardingTitle1.tr(), // Placeholder for now
        'subtitle': LocaleKeys.onboardingSubtitle1.tr(), // Placeholder for now
      },
      {
        'icon': Icons.star, // Placeholder icon
        'title': LocaleKeys.onboardingTitle1.tr(), // Placeholder for now
        'subtitle': LocaleKeys.onboardingSubtitle1.tr(), // Placeholder for now
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top: Skip button aligned to the end
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                  onTap: () => context.go('/location-permission'),
                  child: Text(
                    LocaleKeys.skip.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.electricBlue,
                    ),
                  ),
                ),
              ),
            ),

            // Center: PageView with content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pagesData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final data = pagesData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Pulsing search icon card
                      PulsingIcon(
                        icon: data['icon'] as IconData,
                        iconSize: 80,
                        containerSize: 280,
                      ),
                      const SizedBox(height: 40),

                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Text(
                          data['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            height: 1.3,
                          ),
                        ),
                      ).animate(key: ValueKey('title_$index')).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                      const SizedBox(height: 16),

                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Text(
                          data['subtitle'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white.withValues(alpha: 0.6),
                            height: 1.6,
                          ),
                        ),
                      ).animate(key: ValueKey('subtitle_$index')).fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                    ],
                  );
                },
              ),
            ),

            // Bottom: Animated Dot indicators + Next button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicators — moving animated
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pagesData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _buildAnimatedDot(index == _currentPage),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Next button — aligned to the end
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < pagesData.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            context.go('/location-permission');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.neonGreen,
                          foregroundColor: AppColors.background,
                          elevation: 0,
                          shadowColor: AppColors.neonGreen.withValues(alpha: 0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.next.tr(), // Using next logic or get started if last
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 400.ms).slideX(begin: 0.2, end: 0, curve: Curves.easeOutBack),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dynamic Animated Dot!
  Widget _buildAnimatedDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      width: isActive ? 32 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.neonGreen : AppColors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(isActive ? 4 : 3),
      ),
    );
  }
}
