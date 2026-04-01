import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/social_auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<SocialAuthUserModel> signInWithGoogle();
  Future<SocialAuthUserModel> signInWithApple();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

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
