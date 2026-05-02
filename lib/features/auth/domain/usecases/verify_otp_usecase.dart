import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/otp_purpose.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<void, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(
      emailOrPhone: params.emailOrPhone,
      code: params.code,
      purpose: params.purpose,
    );
  }
}

class VerifyOtpParams {
  final String emailOrPhone;
  final String code;
  final OtpPurpose purpose;

  VerifyOtpParams({
    required this.emailOrPhone,
    required this.code,
    required this.purpose,
  });
}
