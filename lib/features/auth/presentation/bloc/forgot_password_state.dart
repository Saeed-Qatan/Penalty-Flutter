import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const ForgotPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
