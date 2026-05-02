import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/domain/entities/otp_purpose.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/onboarding_page.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'features/auth/presentation/pages/sign_up_page.dart';
import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/auth/presentation/pages/otp_verification_page.dart';
import 'features/auth/presentation/pages/account_created_success_page.dart';
import 'features/auth/presentation/pages/reset_password_page.dart';
import 'features/location/presentation/pages/location_permission_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/pages/discover_view.dart';
import 'features/search/presentation/pages/search_view.dart';
import 'features/booking/presentation/pages/bookings_view.dart';
import 'features/profile/presentation/pages/profile_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/location-permission',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LocationPermissionPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignInPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ForgotPasswordPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/verify-otp',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final emailOrPhone = extra['emailOrPhone'] as String? ?? '';
        final purpose = extra['purpose'] as OtpPurpose? ?? OtpPurpose.recovery;
        return CustomTransitionPage(
          key: state.pageKey,
          child: OtpVerificationPage(
            emailOrPhone: emailOrPhone,
            purpose: purpose,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/reset-password',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ResetPasswordPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/account-created-success',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AccountCreatedSuccessPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const DiscoverView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookings',
              builder: (context, state) => const BookingsView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
