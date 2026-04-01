import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/sso_button.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';
import '../bloc/sign_in_state.dart';
import '../../../../injection_container.dart';

import '../widgets/sign_in_logo.dart';
import '../widgets/sign_in_divider.dart';
import '../widgets/sign_in_footer.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignInBloc>(),
      child: const _SignInView(),
    );
  }
}

class _SignInView extends StatefulWidget {
  const _SignInView();

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // Google SVG-style icon (painted with CustomPaint to
  // keep the multi-color look without an SVG dependency)
  // ─────────────────────────────────────────────
  Widget _googleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // TODO: Navigate to home
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red.shade800,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Logo Section ──
                      const SizedBox(height: 16),
                      const SignInLogo(),
                      const SizedBox(height: 24),

                      // ── Title ──
                      Text(
                        LocaleKeys.signIn.tr(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Email / Phone Input ──
                      AppInputField(
                        controller: _emailController,
                        hintText: LocaleKeys.emailOrPhone.tr(),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),

                      // ── Password Input ──
                      AppInputField(
                        controller: _passwordController,
                        hintText: LocaleKeys.password.tr(),
                        obscureText: !state.isPasswordVisible,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<SignInBloc>()
                                .add(const TogglePasswordVisibility());
                          },
                          icon: Icon(
                            state.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textTertiary,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Forgot Password ──
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Navigate to forgot password
                          },
                          child: Text(
                            LocaleKeys.forgotPassword.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.electricBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Sign In Button ──
                      PrimaryButton(
                        text: LocaleKeys.signIn.tr(),
                        isLoading: state.isLoading,
                        onPressed: () {
                          context.read<SignInBloc>().add(
                                SignInSubmitted(
                                  emailOrPhone: _emailController.text.trim(),
                                  password: _passwordController.text,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 24),

                      // ── OR Divider ──
                      const SignInDivider(),
                      const SizedBox(height: 24),

                      // ── SSO Buttons ──
                      SsoButton(
                        icon: _googleIcon(),
                        label: LocaleKeys.continueWithGoogle.tr(),
                        onPressed: () {
                          context.read<SignInBloc>().add(const SignInWithGoogleSubmitted());
                        },
                      ),
                      const SizedBox(height: 12),
                      SsoButton(
                        icon: const Icon(Icons.apple, color: AppColors.white, size: 24),
                        label: LocaleKeys.continueWithApple.tr(),
                        onPressed: () {
                          context.read<SignInBloc>().add(const SignInWithAppleSubmitted());
                        },
                      ),
                      const SizedBox(height: 32),

                      // ── Footer: Sign Up Link ──
                      SignInFooter(
                        onSignUpTap: () {
                          // TODO: Navigate to Sign Up
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ──────────────────────────────────────────────────
// Google "G" logo painted with the official brand colors
// ──────────────────────────────────────────────────
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;
    final double r = w * 0.45;

    // Blue arc (top-right)
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -0.9, // ~-50°
      1.7, // ~100°
      false,
      bluePaint,
    );

    // Green arc (bottom-right)
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      0.8,
      1.2,
      false,
      greenPaint,
    );

    // Yellow arc (bottom-left)
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      2.0,
      1.0,
      false,
      yellowPaint,
    );

    // Red arc (top-left)
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      3.0,
      1.4,
      false,
      redPaint,
    );

    // Horizontal bar of the "G"
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(cx, cy - w * 0.08, cx + r + w * 0.09, cy + w * 0.08),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
