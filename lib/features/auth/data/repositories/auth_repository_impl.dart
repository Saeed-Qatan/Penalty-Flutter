import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/otp_purpose.dart';
import '../../domain/entities/social_auth_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signUp({
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signUp(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        mobile: mobile,
        password: password,
      );
      return Right(userModel);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signIn(
        emailOrPhone: emailOrPhone,
        password: password,
      );
      return Right(userModel);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String emailOrPhone) async {
    try {
      await remoteDataSource.forgotPassword(emailOrPhone);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String emailOrPhone,
    required String code,
    required OtpPurpose purpose,
  }) async {
    try {
      await remoteDataSource.verifyOtp(
        emailOrPhone: emailOrPhone,
        code: code,
        purpose: purpose,
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendOtp({
    required String emailOrPhone,
    required OtpPurpose purpose,
  }) async {
    try {
      await remoteDataSource.resendOtp(
        emailOrPhone: emailOrPhone,
        purpose: purpose,
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String newPassword}) async {
    try {
      await remoteDataSource.resetPassword(newPassword: newPassword);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SocialAuthUser>> signInWithGoogle() async {
    try {
      final userModel = await remoteDataSource.signInWithGoogle();
      return Right(userModel);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SocialAuthUser>> signInWithApple() async {
    try {
      final userModel = await remoteDataSource.signInWithApple();
      return Right(userModel);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
