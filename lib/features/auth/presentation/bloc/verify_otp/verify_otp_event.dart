import 'package:equatable/equatable.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object?> get props => [];
}

class VerifyOtpSubmitted extends VerifyOtpEvent {
  final String emailOrPhone;
  final String code;

  const VerifyOtpSubmitted({
    required this.emailOrPhone,
    required this.code,
  });

  @override
  List<Object?> get props => [emailOrPhone, code];
}

class ResendOtpRequested extends VerifyOtpEvent {
  final String emailOrPhone;

  const ResendOtpRequested({required this.emailOrPhone});

  @override
  List<Object?> get props => [emailOrPhone];
}
