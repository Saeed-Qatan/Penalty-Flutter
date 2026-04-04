import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/social_auth_user_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
  });

  Future<UserModel> signIn({
    required String emailOrPhone,
    required String password,
  });

  Future<void> forgotPassword(String emailOrPhone);

  Future<SocialAuthUserModel> signInWithGoogle();
  Future<SocialAuthUserModel> signInWithApple();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> signUp({
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return UserModel(
        id: 'mock_id_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        mobile: mobile,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signIn({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return UserModel(
        id: 'mock_id_auth',
        email: emailOrPhone.contains('@') ? emailOrPhone : 'user@example.com',
        firstName: 'John',
        middleName: '',
        lastName: 'Doe',
        mobile: emailOrPhone.contains('@') ? '0500000000' : emailOrPhone,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String emailOrPhone) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<SocialAuthUserModel> signInWithGoogle() async {
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final auth = account.authentication;

      return SocialAuthUserModel(
        id: account.id,
        email: account.email,
        name: account.displayName,
        idToken: auth.idToken,
        accessToken: null,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<SocialAuthUserModel> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return SocialAuthUserModel(
        id: credential.userIdentifier ?? '',
        email: credential.email,
        name: credential.givenName != null
            ? '${credential.givenName} ${credential.familyName}'
            : null,
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
