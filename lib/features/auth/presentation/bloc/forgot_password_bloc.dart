import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc({required this.forgotPasswordUseCase}) : super(const ForgotPasswordState()) {
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
  }

  Future<void> _onForgotPasswordSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await forgotPasswordUseCase(
      ForgotPasswordParams(emailOrPhone: event.emailOrPhone),
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
