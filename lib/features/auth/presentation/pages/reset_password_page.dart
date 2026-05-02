import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../injection_container.dart';
import '../bloc/reset_password/reset_password_bloc.dart';
import '../bloc/reset_password/reset_password_event.dart';
import '../bloc/reset_password/reset_password_state.dart';
import '../widgets/form_label.dart';
import '../widgets/password_strength_indicator.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ResetPasswordBloc>(),
      child: const _ResetPasswordView(),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  const _ResetPasswordView();

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<_ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.fieldRequired.tr();
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.fieldRequired.tr();
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.isSuccess) {
          AppSnackBar.showSuccess(
            context,
            LocaleKeys.passwordResetSuccess.tr(),
          );
          context.go('/login');
        }
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                          size: 24,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Text(
                          LocaleKeys.resetPasswordTitle.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance the back button
                    ],
                  ),
                ),

                // Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Lock Icon
                            Center(
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.neonGreen
                                        .withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.neonGreen
                                          .withValues(alpha: 0.1),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.lock_reset_rounded,
                                  color: AppColors.neonGreen,
                                  size: 36,
                                ),
                              ),
                            )
                                .animate()
                                .scale(
                                    delay: 100.ms,
                                    duration: 500.ms,
                                    curve: Curves.easeOutBack)
                                .fadeIn(),
                            const SizedBox(height: 24),

                            // Title
                            Center(
                              child: Text(
                                LocaleKeys.resetPasswordTitle.tr(),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 200.ms, duration: 400.ms)
                                .slideY(begin: 0.2, end: 0),
                            const SizedBox(height: 8),

                            // Subtitle
                            Center(
                              child: Text(
                                LocaleKeys.resetPasswordSubtitle.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      AppColors.white.withValues(alpha: 0.6),
                                  height: 1.5,
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 300.ms, duration: 400.ms)
                                .slideY(begin: 0.2, end: 0),
                            const SizedBox(height: 36),

                            // New Password
                            FormLabel(text: LocaleKeys.newPassword.tr()),
                            AppInputField(
                              controller: _newPasswordController,
                              hintText: '••••••••',
                              obscureText: !state.isNewPasswordVisible,
                              textInputAction: TextInputAction.next,
                              validator: _passwordValidator,
                              onChanged: (val) {
                                context
                                    .read<ResetPasswordBloc>()
                                    .add(ResetPasswordChanged(val));
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<ResetPasswordBloc>().add(
                                        const ToggleNewPasswordVisibility(),
                                      );
                                },
                                icon: Icon(
                                  state.isNewPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ),
                            // Strength Indicator
                            PasswordStrengthIndicator(
                                strength: state.passwordStrength),
                            const SizedBox(height: 24),

                            // Confirm New Password
                            FormLabel(
                                text: LocaleKeys.confirmNewPassword.tr()),
                            AppInputField(
                              controller: _confirmPasswordController,
                              hintText: '••••••••',
                              obscureText: !state.isConfirmPasswordVisible,
                              textInputAction: TextInputAction.done,
                              validator: _confirmPasswordValidator,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<ResetPasswordBloc>().add(
                                        const ToggleConfirmPasswordVisibility(),
                                      );
                                },
                                icon: Icon(
                                  state.isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: PrimaryButton(
                      text: LocaleKeys.resetPassword.tr(),
                      isLoading: state.isLoading,
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        context.read<ResetPasswordBloc>().add(
                              ResetPasswordSubmitted(
                                newPassword:
                                    _newPasswordController.text,
                                confirmPassword:
                                    _confirmPasswordController.text,
                              ),
                            );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
