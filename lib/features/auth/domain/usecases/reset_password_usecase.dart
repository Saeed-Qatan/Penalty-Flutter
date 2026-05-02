import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) {
    return repository.resetPassword(newPassword: params.newPassword);
  }
}

class ResetPasswordParams extends Equatable {
  final String newPassword;

  const ResetPasswordParams({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}
