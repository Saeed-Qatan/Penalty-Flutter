import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) {
    return repository.signIn(
      emailOrPhone: params.emailOrPhone,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String emailOrPhone;
  final String password;

  const SignInParams({
    required this.emailOrPhone,
    required this.password,
  });

  @override
  List<Object> get props => [emailOrPhone, password];
}
