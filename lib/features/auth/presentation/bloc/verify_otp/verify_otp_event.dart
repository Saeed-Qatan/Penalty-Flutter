import 'package:equatable/equatable.dart';
import '../../../domain/entities/otp_purpose.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object?> get props => [];
}

class VerifyOtpSubmitted extends VerifyOtpEvent {
  final String emailOrPhone;
  final String code;
  final OtpPurpose purpose;

  const VerifyOtpSubmitted({
    required this.emailOrPhone,
    required this.code,
    required this.purpose,
  });

  @override
  List<Object?> get props => [emailOrPhone, code, purpose];
}

class ResendOtpRequested extends VerifyOtpEvent {
  final String emailOrPhone;
  final OtpPurpose purpose;

  const ResendOtpRequested({
    required this.emailOrPhone,
    required this.purpose,
  });

  @override
  List<Object?> get props => [emailOrPhone, purpose];
}
