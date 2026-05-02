import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/otp_purpose.dart';
import '../repositories/auth_repository.dart';

class ResendOtpUseCase implements UseCase<void, ResendOtpParams> {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResendOtpParams params) {
    return repository.resendOtp(
      emailOrPhone: params.emailOrPhone,
      purpose: params.purpose,
    );
  }
}

class ResendOtpParams extends Equatable {
  final String emailOrPhone;
  final OtpPurpose purpose;

  const ResendOtpParams({
    required this.emailOrPhone,
    required this.purpose,
  });

  @override
  List<Object> get props => [emailOrPhone, purpose];
}
