import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/social_auth_user.dart';
import '../repositories/auth_repository.dart';

class SignInWithAppleUseCase implements UseCase<SocialAuthUser, NoParams> {
  final AuthRepository repository;

  SignInWithAppleUseCase(this.repository);

  @override
  Future<Either<Failure, SocialAuthUser>> call(NoParams params) {
    return repository.signInWithApple();
  }
}
