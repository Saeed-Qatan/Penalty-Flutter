import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return repository.signUp(
      firstName: params.firstName,
      middleName: params.middleName,
      lastName: params.lastName,
      email: params.email,
      mobile: params.mobile,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;

  const SignUpParams({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
  });

  @override
  List<Object> get props => [
        firstName,
        middleName,
        lastName,
        email,
        mobile,
        password,
      ];
}
