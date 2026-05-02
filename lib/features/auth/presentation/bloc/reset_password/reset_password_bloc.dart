import 'package:flutter_bloc/flutter_bloc.dart';
import '../sign_up_state.dart'; // reuse PasswordStrength enum
import '../../../domain/usecases/reset_password_usecase.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordBloc({required this.resetPasswordUseCase})
      : super(const ResetPasswordState()) {
    on<ResetPasswordSubmitted>(_onSubmitted);
    on<ToggleNewPasswordVisibility>(_onToggleNewPassword);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPassword);
    on<ResetPasswordChanged>(_onPasswordChanged);
  }

  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Validations
    if (event.newPassword != event.confirmPassword) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Passwords do not match.',
      ));
      return;
    }

    if (event.newPassword.length < 8) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Password must be at least 8 characters.',
      ));
      return;
    }

    if (state.passwordStrength == PasswordStrength.weak) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Password is too weak.',
      ));
      return;
    }

    final result = await resetPasswordUseCase(
      ResetPasswordParams(newPassword: event.newPassword),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      )),
    );
  }

  void _onToggleNewPassword(
    ToggleNewPasswordVisibility event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  void _onToggleConfirmPassword(
    ToggleConfirmPasswordVisibility event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void _onPasswordChanged(
    ResetPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    if (event.password.isEmpty) {
      emit(state.copyWith(passwordStrength: PasswordStrength.none));
      return;
    }

    final password = event.password;
    if (password.length < 6) {
      emit(state.copyWith(passwordStrength: PasswordStrength.weak));
    } else {
      bool hasLetters = RegExp(r'[a-zA-Z]').hasMatch(password);
      bool hasNumbers = RegExp(r'[0-9]').hasMatch(password);
      bool hasSymbols = RegExp(r'[!@#\$&*~]').hasMatch(password);

      if (password.length >= 8 && hasLetters && hasNumbers && hasSymbols) {
        emit(state.copyWith(passwordStrength: PasswordStrength.strong));
      } else if (password.length >= 6 && hasLetters && hasNumbers) {
        emit(state.copyWith(passwordStrength: PasswordStrength.medium));
      } else {
        emit(state.copyWith(passwordStrength: PasswordStrength.weak));
      }
    }
  }
}
