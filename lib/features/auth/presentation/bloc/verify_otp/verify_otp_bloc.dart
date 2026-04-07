import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import 'verify_otp_event.dart';
import 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  VerifyOtpBloc({
    required this.verifyOtpUseCase,
    required this.forgotPasswordUseCase,
  }) : super(const VerifyOtpState()) {
    on<VerifyOtpSubmitted>(_onVerifyOtpSubmitted);
    on<ResendOtpRequested>(_onResendOtpRequested);
  }

  Future<void> _onVerifyOtpSubmitted(
    VerifyOtpSubmitted event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(state.clearError().copyWith(isLoading: true));

    final result = await verifyOtpUseCase(
      VerifyOtpParams(
        emailOrPhone: event.emailOrPhone,
        code: event.code,
      ),
    );

    result.fold(
      (failure) => emit(state.clearError().copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.clearError().copyWith(
        isLoading: false,
        isSuccess: true,
      )),
    );
  }

  Future<void> _onResendOtpRequested(
    ResendOtpRequested event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(state.clearError().copyWith(resendLoading: true, resendSuccess: false));

    final result = await forgotPasswordUseCase(
      ForgotPasswordParams(emailOrPhone: event.emailOrPhone),
    );

    result.fold(
      (failure) => emit(state.clearError().copyWith(
        resendLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.clearError().copyWith(
        resendLoading: false,
        resendSuccess: true,
      )),
    );
  }
}
