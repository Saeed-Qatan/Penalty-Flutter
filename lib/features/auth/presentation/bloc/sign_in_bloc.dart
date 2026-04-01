import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<SignInSubmitted>(_onSignInSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // TODO: Replace with real auth use-case call
    await Future.delayed(const Duration(seconds: 2));

    // Placeholder — always succeed for now
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}
