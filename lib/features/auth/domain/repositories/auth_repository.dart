import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/social_auth_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, SocialAuthUser>> signInWithGoogle();
  Future<Either<Failure, SocialAuthUser>> signInWithApple();
}
