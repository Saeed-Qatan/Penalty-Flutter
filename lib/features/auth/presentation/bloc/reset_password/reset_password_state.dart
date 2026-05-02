import 'package:equatable/equatable.dart';
import '../sign_up_state.dart'; // reuse PasswordStrength enum

class ResetPasswordState extends Equatable {
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final PasswordStrength passwordStrength;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const ResetPasswordState({
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.passwordStrength = PasswordStrength.none,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ResetPasswordState copyWith({
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    PasswordStrength? passwordStrength,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isNewPasswordVisible,
        isConfirmPasswordVisible,
        passwordStrength,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}
