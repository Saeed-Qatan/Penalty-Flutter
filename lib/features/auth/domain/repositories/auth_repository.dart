import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/otp_purpose.dart';
import '../entities/social_auth_user.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUp({
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
  });

  Future<Either<Failure, User>> signIn({
    required String emailOrPhone,
    required String password,
  });

  Future<Either<Failure, void>> forgotPassword(String emailOrPhone);

  Future<Either<Failure, void>> verifyOtp({
    required String emailOrPhone,
    required String code,
    required OtpPurpose purpose,
  });

  Future<Either<Failure, void>> resendOtp({
    required String emailOrPhone,
    required OtpPurpose purpose,
  });

  Future<Either<Failure, void>> resetPassword({required String newPassword});

  Future<Either<Failure, SocialAuthUser>> signInWithGoogle();
  Future<Either<Failure, SocialAuthUser>> signInWithApple();
}
