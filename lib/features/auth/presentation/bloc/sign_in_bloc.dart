import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_in_with_apple_usecase.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithAppleUseCase signInWithAppleUseCase;

  SignInBloc({
    required this.signInWithGoogleUseCase,
    required this.signInWithAppleUseCase,
  }) : super(const SignInState()) {
    on<SignInSubmitted>(_onSignInSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<SignInWithGoogleSubmitted>(_onSignInWithGoogleSubmitted);
    on<SignInWithAppleSubmitted>(_onSignInWithAppleSubmitted);
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2)); // Placeholder
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onSignInWithGoogleSubmitted(
    SignInWithGoogleSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await signInWithGoogleUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  Future<void> _onSignInWithAppleSubmitted(
    SignInWithAppleSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await signInWithAppleUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
