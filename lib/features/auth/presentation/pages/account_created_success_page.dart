import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';

class AccountCreatedSuccessPage extends StatelessWidget {
  const AccountCreatedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Center content mapping to HTML <main> tag
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon Container
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer Glow Ring (Decorative)
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.neonGreen.withValues(alpha: 0.1),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.neonGreen.withValues(alpha: 0.1),
                                blurRadius: 60,
                                spreadRadius: 30,
                              ),
                            ],
                          ),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                         .scaleXY(begin: 0.9, end: 1.1, duration: 2000.ms, curve: Curves.easeInOut),
                         
                        // Icon Circle
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surface,
                            border: Border.all(
                              color: AppColors.neonGreen.withValues(alpha: 0.3),
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.neonGreen.withValues(alpha: 0.15),
                                blurRadius: 40,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: AppColors.neonGreen,
                            size: 64,
                          ),
                        ),
                      ],
                    ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack),
                    
                    const SizedBox(height: 40),
                    
                    // Title
                    Text(
                      LocaleKeys.accountCreatedSuccessTitle.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                    
                    const SizedBox(height: 16),
                    
                    // Subtitle
                    Text(
                      LocaleKeys.accountCreatedSuccessSubtitle.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white.withValues(alpha: 0.6),
                        height: 1.6,
                      ),
                    ).animate().fadeIn(delay: 500.ms, duration: 500.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                  ],
                ),
              ),
            ),

            // Bottom Action Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to home after successful account creation
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: AppColors.background,
                    elevation: 0,
                    shadowColor: AppColors.neonGreen.withValues(alpha: 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.startNow.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Arrow icon adapts to RTL by default if wrapped right, but we can enforce it.
                      Transform.flip(
                        flipX: context.locale.languageCode == 'ar',
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms, duration: 500.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
            ),
          ],
        ),
      ),
    );
  }
}
