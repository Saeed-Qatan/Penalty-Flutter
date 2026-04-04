import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(const SignUpState()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<PasswordChanged>(_onPasswordChanged);
    on<ToggleSignUpPasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleSignUpConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<ToggleTermsAggreement>(_onToggleTerms);
    on<ToggleReceiveAlerts>(_onToggleAlerts);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    // Reset state and show loading
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    // Validations
    if (event.password != event.confirmPassword) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Passwords do not match.'));
      return;
    }

    if (state.passwordStrength == PasswordStrength.weak) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Password is too weak.'));
      return;
    }
    
    if (!event.agreeToTerms) {
      emit(state.copyWith(isLoading: false, errorMessage: 'You must agree to the terms and conditions.'));
      return;
    }

    final result = await signUpUseCase(
      SignUpParams(
        firstName: event.firstName,
        middleName: event.middleName,
        lastName: event.lastName,
        email: event.email,
        mobile: event.mobile,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<SignUpState> emit,
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

  void _onTogglePasswordVisibility(
    ToggleSignUpPasswordVisibility event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility(
    ToggleSignUpConfirmPasswordVisibility event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void _onToggleTerms(
    ToggleTermsAggreement event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(agreeToTerms: !state.agreeToTerms));
  }

  void _onToggleAlerts(
    ToggleReceiveAlerts event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(receiveAlerts: !state.receiveAlerts));
  }
}
