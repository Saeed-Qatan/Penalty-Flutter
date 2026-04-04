import 'package:equatable/equatable.dart';

enum PasswordStrength { none, weak, medium, strong }

class SignUpState extends Equatable {
  const SignUpState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.passwordStrength = PasswordStrength.none,
    this.agreeToTerms = true,
    this.receiveAlerts = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final PasswordStrength passwordStrength;
  final bool agreeToTerms;
  final bool receiveAlerts;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  SignUpState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    PasswordStrength? passwordStrength,
    bool? agreeToTerms,
    bool? receiveAlerts,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      receiveAlerts: receiveAlerts ?? this.receiveAlerts,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isPasswordVisible,
        isConfirmPasswordVisible,
        passwordStrength,
        agreeToTerms,
        receiveAlerts,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}
