import 'package:equatable/equatable.dart';

class VerifyOtpState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool resendLoading;
  final bool resendSuccess;

  const VerifyOtpState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.resendLoading = false,
    this.resendSuccess = false,
  });

  VerifyOtpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? resendLoading,
    bool? resendSuccess,
  }) {
    return VerifyOtpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage, // We want to be able to set it to null sometimes, but standard copyWith behaviour makes it tricky. We'll pass it explicitly when needed or clear it. Actually let's allow nulling it.
      // A better pattern for nullable fields in copyWith:
      // If we don't pass errorMessage, it keeps the old one. If we want to clear it, we'd need a special mechanism or just separate states.
      // But let's stick to the simple one: if errorMessage is provided, use it. If clearError is conceptually needed, we can just say errorMessage: null but since it's nullable we can't distinguish.
      resendLoading: resendLoading ?? this.resendLoading,
      resendSuccess: resendSuccess ?? this.resendSuccess,
    );
  }

  // Helper method explicitly for clearing error
  VerifyOtpState clearError() {
    return VerifyOtpState(
      isLoading: isLoading,
      isSuccess: isSuccess,
      errorMessage: null,
      resendLoading: resendLoading,
      resendSuccess: resendSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        resendLoading,
        resendSuccess,
      ];
}
