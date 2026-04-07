import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<void, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(
      emailOrPhone: params.emailOrPhone,
      code: params.code,
    );
  }
}

class VerifyOtpParams {
  final String emailOrPhone;
  final String code;

  VerifyOtpParams({
    required this.emailOrPhone,
    required this.code,
  });
}
