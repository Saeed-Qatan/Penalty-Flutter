import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../widgets/animated_loading_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      final session = Supabase.instance.client.auth.currentSession;

      // ─── مستخدم مسجّل دخول ───────────────────────────────
      if (session != null) {
        context.go('/home');
        return;
      }

      // ─── فحص "أول مرة" عبر SharedPreferences ────────────
      final prefs = await SharedPreferences.getInstance();
      final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

      if (!mounted) return;

      if (hasSeenOnboarding) {
        // مستخدم عائد — تجاهل الـ Onboarding وادخل مباشرةً للـ Login
        context.go('/login');
      } else {
        // أول مرة — أظهر الـ Onboarding
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(), // Flexible spacer top
              // Center Branding
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '🏟️',
                      style: TextStyle(
                        fontSize: 64,
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    LocaleKeys.splashTitle.tr(),
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      color: AppColors.neonGreen,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    LocaleKeys.splashSubtitle.tr(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocaleKeys.splashSlogan.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white.withValues(alpha: 0.6),
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 500.ms).slideY(begin: 0.2, end: 0),
                ],
              ).animate().fadeIn(duration: 500.ms).scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack),

              // Bottom Loader
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AnimatedLoadingBar(),
                    const SizedBox(height: 12),
                    Text(
                      LocaleKeys.splashLoading.tr(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
