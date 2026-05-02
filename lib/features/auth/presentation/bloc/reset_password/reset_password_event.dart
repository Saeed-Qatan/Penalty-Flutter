import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordSubmitted({
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [newPassword, confirmPassword];
}

class ToggleNewPasswordVisibility extends ResetPasswordEvent {
  const ToggleNewPasswordVisibility();
}

class ToggleConfirmPasswordVisibility extends ResetPasswordEvent {
  const ToggleConfirmPasswordVisibility();
}

class ResetPasswordChanged extends ResetPasswordEvent {
  final String password;

  const ResetPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}
