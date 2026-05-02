import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/entities/otp_purpose.dart';
import '../bloc/verify_otp/verify_otp_bloc.dart';
import '../bloc/verify_otp/verify_otp_event.dart';
import '../bloc/verify_otp/verify_otp_state.dart';
import '../widgets/custom_numeric_keypad.dart';

class OtpVerificationPage extends StatelessWidget {
  final String emailOrPhone;
  final OtpPurpose purpose;

  const OtpVerificationPage({
    super.key,
    required this.emailOrPhone,
    required this.purpose,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VerifyOtpBloc>(),
      child: _OtpVerificationView(
        emailOrPhone: emailOrPhone,
        purpose: purpose,
      ),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  final String emailOrPhone;
  final OtpPurpose purpose;

  const _OtpVerificationView({
    required this.emailOrPhone,
    required this.purpose,
  });

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  
  Timer? _timer;
  int _secondsRemaining = 59;
  
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  
  void _startTimer() {
    setState(() => _secondsRemaining = 59);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _onDigitPressed(String digit) {
    if (_otpController.text.length < 8) {
      _otpController.text = _otpController.text + digit;
    }
  }

  void _onBackspacePressed() {
    if (_otpController.text.isNotEmpty) {
      _otpController.text = _otpController.text.substring(0, _otpController.text.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';
    
    final defaultPinTheme = PinTheme(
      width: 40, // Reduced from 56 to fit 8 digits on mobile screens
      height: 64, // matching sm:h-16
      textStyle: const TextStyle(
        fontSize: 24,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.neonGreen, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonGreen.withValues(alpha: 0.15),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xFF1E1E1E),
        border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.5)),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.redAccent, width: 2),
        color: Colors.red.withValues(alpha: 0.05),
      ),
    );

    return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
        if (state.isSuccess) {
          AppSnackBar.showSuccess(
            context,
            'Verified successfully',
          );
          // Navigate based on flow purpose
          if (widget.purpose == OtpPurpose.signup) {
            // Sign up: show success screen
            context.go('/account-created-success');
          } else {
            // Recovery: OTP verified → go directly to home
            context.go('/home');
          }
        }
        if (state.resendSuccess) {
          AppSnackBar.showSuccess(
            context,
            LocaleKeys.passwordRecoverySent.tr(), 
          );
          _startTimer();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              // Abstract Glow Background Effects
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -100,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2979FF).withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              
              SafeArea(
                bottom: false, // Custom keypad takes the bottom safe area
                child: Column(
                  children: [
                    // Top App Bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.white,
                              size: 24,
                            ),
                            onPressed: () => context.pop(),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 48), // visually center
                              child: Text(
                                LocaleKeys.confirmCode.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.015,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          children: [
                            // Instructions
                            Text(
                              LocaleKeys.enterCode.tr(),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
                            const SizedBox(height: 12),
                            
                            // Subtitle with RTL/LTR directional support mix from design
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                  height: 1.5,
                                  fontFamily: 'IBM Plex Sans Arabic',
                                ),
                                children: [
                                  TextSpan(text: '${LocaleKeys.codeSentTo.tr()} '),
                                  TextSpan(
                                    text: widget.emailOrPhone,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
                            
                            const SizedBox(height: 32),
                            
                            // Pinput
                            Directionality(
                              textDirection: ui.TextDirection.ltr, // OTP inputs are LTR
                              child: IgnorePointer(
                                // Ignoring pointer to avoid showing native keyboard
                                ignoring: true,
                                child: Pinput(
                                  length: 8,
                                  controller: _otpController,
                                  focusNode: _otpFocusNode,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  errorPinTheme: errorPinTheme,
                                  forceErrorState: state.errorMessage != null,
                                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                  pinAnimationType: PinAnimationType.scale,
                                  animationDuration: const Duration(milliseconds: 200),
                                  separatorBuilder: (index) => const SizedBox(width: 8),
                                  showCursor: true,
                                  cursor: Container(
                                    width: 2,
                                    height: 24,
                                    color: AppColors.neonGreen,
                                    margin: const EdgeInsets.only(bottom: 4),
                                  ),
                                  errorBuilder: (errorText, pin) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Center(
                                        child: Text(
                                          state.errorMessage ?? '',
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // Timer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${LocaleKeys.resendIn.tr()} ',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.45),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (_secondsRemaining > 0)
                                  Text(
                                    '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.45),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Plus Jakarta Sans',
                                    ),
                                  )
                                else
                                  GestureDetector(
                                    onTap: state.resendLoading
                                        ? null
                                        : () {
                                            context.read<VerifyOtpBloc>().add(
                                              ResendOtpRequested(
                                                emailOrPhone: widget.emailOrPhone,
                                                purpose: widget.purpose,
                                              ),
                                            );
                                          },
                                        child: state.resendLoading 
                                      ? const SizedBox(
                                          width: 14, height: 14,
                                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.neonGreen),
                                        )
                                      : Text(
                                          'Resend Now', // You can localize if preferred
                                          style: const TextStyle(
                                            color: AppColors.neonGreen,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                  ),
                              ],
                            ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
                            
                            const SizedBox(height: 32),
                            
                            // Action Button
                            PrimaryButton(
                              text: LocaleKeys.confirm.tr(),
                              isLoading: state.isLoading,
                              onPressed: () {
                                if (_otpController.text.length == 8) {
                                  context.read<VerifyOtpBloc>().add(
                                    VerifyOtpSubmitted(
                                      emailOrPhone: widget.emailOrPhone,
                                      code: _otpController.text,
                                      purpose: widget.purpose,
                                    ),
                                  );
                                } else {
                                  // Optionally show error that 8 digits are required
                                  AppSnackBar.showError(context, 'Please enter an 8-digit code');
                                }
                              },
                            ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
                            
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    
                    // Custom Simulated iOS Numeric Keypad
                    CustomNumericKeypad(
                      onDigitPressed: _onDigitPressed,
                      onBackspacePressed: _onBackspacePressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
