import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted({
    required this.emailOrPhone,
    required this.password,
  });

  final String emailOrPhone;
  final String password;

  @override
  List<Object?> get props => [emailOrPhone, password];
}

class TogglePasswordVisibility extends SignInEvent {
  const TogglePasswordVisibility();
}

class SignInWithGoogleSubmitted extends SignInEvent {
  const SignInWithGoogleSubmitted();
}

class SignInWithAppleSubmitted extends SignInEvent {
  const SignInWithAppleSubmitted();
}
