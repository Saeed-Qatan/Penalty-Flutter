import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String emailOrPhone;

  const ForgotPasswordSubmitted({required this.emailOrPhone});

  @override
  List<Object> get props => [emailOrPhone];
}
