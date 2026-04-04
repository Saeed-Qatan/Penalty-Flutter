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
import '../bloc/forgot_password_bloc.dart';
import '../bloc/forgot_password_event.dart';
import '../bloc/forgot_password_state.dart';
import '../widgets/form_label.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgotPasswordBloc>(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }

  String? _emailOrPhoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.fieldRequired.tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return LocaleKeys.invalidEmailOrPhone.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
        if (state.isSuccess) {
          AppSnackBar.showSuccess(context, LocaleKeys.passwordRecoverySent.tr());
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        LocaleKeys.forgotPasswordTitle.tr(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Subtitle
                      Text(
                        LocaleKeys.forgotPasswordSubtitle.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Input Field
                      FormLabel(text: LocaleKeys.emailOrPhone.tr()),
                      AppInputField(
                        controller: _emailOrPhoneController,
                        hintText: LocaleKeys.enterDetailsHere.tr(),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: _emailOrPhoneValidator,
                      ),
                      const SizedBox(height: 24),

                      // Button
                      PrimaryButton(
                        text: LocaleKeys.sendCode.tr(),
                        isLoading: state.isLoading,
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordSubmitted(
                              emailOrPhone: _emailOrPhoneController.text,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Remember Password link
                      Center(
                        child: TextButton(
                          onPressed: () => context.pop(),
                          child: Text(
                            LocaleKeys.rememberPasswordSignIn.tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Optional Footer Graphic matching design request
                      Opacity(
                        opacity: 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDPzDnEnPccKHpc4wJ1TRCSMiEhUOGDNJ8fanf2qFrpB4ukfXpWOew4U-Q3W6X8prnTVa43EO4Veti9sPvRAvNCCbIvLdPxCChF1kz7RiaaQl1gmORnJE3ZSJqUiBU6_IR6moITx56dQd12tEDU2wQtJTOEYNe85VP5FgK8a0M5SoBimLO1n8elMbXM18obRUotPrP74V3DOIRMf6TbVPEbK_rWjwh-FX-BhKmnywe_7ktxwATTcyxnomX8mrGC-bAWjMNqlkofRgMb',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox(height: 200),
                            ),
                          ),
                        ),
                      ),
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

