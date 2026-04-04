import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
    required this.confirmPassword,
    required this.agreeToTerms,
    required this.receiveAlerts,
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;
  final String confirmPassword;
  final bool agreeToTerms;
  final bool receiveAlerts;

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        email,
        mobile,
        password,
        confirmPassword,
        agreeToTerms,
        receiveAlerts,
      ];
}

class PasswordChanged extends SignUpEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object?> get props => [password];
}

class ToggleSignUpPasswordVisibility extends SignUpEvent {
  const ToggleSignUpPasswordVisibility();
}

class ToggleSignUpConfirmPasswordVisibility extends SignUpEvent {
  const ToggleSignUpConfirmPasswordVisibility();
}

class ToggleTermsAggreement extends SignUpEvent {
  const ToggleTermsAggreement();
}

class ToggleReceiveAlerts extends SignUpEvent {
  const ToggleReceiveAlerts();
}
