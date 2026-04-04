import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase implements UseCase<void, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) {
    return repository.forgotPassword(params.emailOrPhone);
  }
}

class ForgotPasswordParams extends Equatable {
  final String emailOrPhone;

  const ForgotPasswordParams({required this.emailOrPhone});

  @override
  List<Object> get props => [emailOrPhone];
}
