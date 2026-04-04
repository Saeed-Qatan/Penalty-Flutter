import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../injection_container.dart';
import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_event.dart';
import '../bloc/sign_up_state.dart';
import '../widgets/custom_checkbox_row.dart';
import '../widgets/form_label.dart';
import '../widgets/password_strength_indicator.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpBloc>(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.go('/location-permission');
        }
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background.withOpacity(0.9),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              LocaleKeys.createNewAccount.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── First Name ──
                      FormLabel(text: LocaleKeys.firstName.tr()),
                      AppInputField(
                        controller: _firstNameController,
                        hintText: LocaleKeys.firstName.tr(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: _requiredValidator,
                        suffixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Middle Name ──
                      FormLabel(text: LocaleKeys.middleName.tr()),
                      AppInputField(
                        controller: _middleNameController,
                        hintText: LocaleKeys.middleName.tr(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: _requiredValidator,
                        suffixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Last Name ──
                      FormLabel(text: LocaleKeys.lastName.tr()),
                      AppInputField(
                        controller: _lastNameController,
                        hintText: LocaleKeys.lastName.tr(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: _requiredValidator,
                        suffixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Email ──
                      FormLabel(text: LocaleKeys.email.tr()),
                      AppInputField(
                        controller: _emailController,
                        hintText: "name@example.com",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: _emailValidator,
                        suffixIcon: const Icon(
                          Icons.mail_outline,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Mobile ──
                      FormLabel(text: LocaleKeys.mobileNumber.tr()),
                      AppInputField(
                        controller: _mobileController,
                        hintText: "05xxxxxxxx",
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: _requiredValidator,
                        suffixIcon: const Icon(
                          Icons.smartphone,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Password ──
                      FormLabel(text: LocaleKeys.password.tr()),
                      AppInputField(
                        controller: _passwordController,
                        hintText: "••••••••",
                        obscureText: !state.isPasswordVisible,
                        textInputAction: TextInputAction.next,
                        validator: _passwordValidator,
                        onChanged: (val) {
                          context.read<SignUpBloc>().add(PasswordChanged(val));
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<SignUpBloc>().add(
                              const ToggleSignUpPasswordVisibility(),
                            );
                          },
                          icon: Icon(
                            state.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                      // Strength Indicator
                      PasswordStrengthIndicator(strength: state.passwordStrength),
                      const SizedBox(height: 20),

                      // ── Confirm Password ──
                      FormLabel(text: LocaleKeys.confirmPassword.tr()),
                      AppInputField(
                        controller: _confirmPasswordController,
                        hintText: "••••••••",
                        obscureText: !state.isConfirmPasswordVisible,
                        textInputAction: TextInputAction.done,
                        validator: _requiredValidator,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<SignUpBloc>().add(
                              const ToggleSignUpConfirmPasswordVisibility(),
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
                      const SizedBox(height: 24),

                      // ── Checkboxes ──
                      CustomCheckboxRow(
                        label: LocaleKeys.agreeToTerms.tr(),
                        value: state.agreeToTerms,
                        onTap: () => context.read<SignUpBloc>().add(
                          const ToggleTermsAggreement(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomCheckboxRow(
                        label: LocaleKeys.receiveAlerts.tr(),
                        value: state.receiveAlerts,
                        onTap: () => context.read<SignUpBloc>().add(
                          const ToggleReceiveAlerts(),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: PrimaryButton(
                text: LocaleKeys.createAccount.tr(),
                isLoading: state.isLoading,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  context.read<SignUpBloc>().add(
                    SignUpSubmitted(
                      firstName: _firstNameController.text,
                      middleName: _middleNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      mobile: _mobileController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                      agreeToTerms: state.agreeToTerms,
                      receiveAlerts: state.receiveAlerts,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
