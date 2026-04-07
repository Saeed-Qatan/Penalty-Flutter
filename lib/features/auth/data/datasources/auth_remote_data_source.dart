import 'package:google_sign_in/google_sign_in.dart' as google_auth;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  Future<void> verifyOtp({
    required String emailOrPhone,
    required String code,
  });

  Future<SocialAuthUserModel> signInWithGoogle();
  Future<SocialAuthUserModel> signInWithApple();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

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
      final AuthResponse response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'middle_name': middleName,
          'last_name': lastName,
          'mobile': mobile,
        },
      );

      final user = response.user;
      if (user == null) {
        throw const AppException(message: 'Failed to create user. Unknown error occurred.');
      }

      return UserModel(
        id: user.id,
        email: user.email ?? email,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        mobile: mobile,
      );
    } on AuthException catch (e) {
      throw AppException(message: e.message);
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
      final isEmail = emailOrPhone.contains('@');
      final AuthResponse response;

      if (isEmail) {
        response = await supabaseClient.auth.signInWithPassword(
          email: emailOrPhone,
          password: password,
        );
      } else {
        response = await supabaseClient.auth.signInWithPassword(
          phone: emailOrPhone,
          password: password,
        );
      }

      final user = response.user;
      if (user == null) {
        throw const AppException(message: 'Sign in failed');
      }

      final meta = user.userMetadata ?? {};

      return UserModel(
        id: user.id,
        email: user.email ?? (isEmail ? emailOrPhone : ''),
        firstName: meta['first_name'] ?? '',
        middleName: meta['middle_name'] ?? '',
        lastName: meta['last_name'] ?? '',
        mobile: meta['mobile'] ?? (!isEmail ? emailOrPhone : ''),
      );
    } on AuthException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String emailOrPhone) async {
    try {
      final isEmail = emailOrPhone.contains('@');
      if (isEmail) {
        await supabaseClient.auth.resetPasswordForEmail(emailOrPhone);
      } else {
        await supabaseClient.auth.signInWithOtp(phone: emailOrPhone);
      }
    } on AuthException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> verifyOtp({
    required String emailOrPhone,
    required String code,
  }) async {
    try {
      final isEmail = emailOrPhone.contains('@');
      final AuthResponse response = await supabaseClient.auth.verifyOTP(
        type: isEmail ? OtpType.email : OtpType.sms,
        token: code,
        email: isEmail ? emailOrPhone : null,
        phone: !isEmail ? emailOrPhone : null,
      );

      if (response.user == null) {
        throw const AppException(message: 'Verification failed. Invalid OTP.');
      }
    } on AuthException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<SocialAuthUserModel> signInWithGoogle() async {
    try {
      final account = await google_auth.GoogleSignIn.instance.authenticate();
      
      final auth = account.authentication;
      if (auth.idToken == null) {
        throw const AppException(message: 'No ID token found.');
      }

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: auth.idToken!,
      );

      if (response.user == null) {
        throw const AppException(message: 'Google Sign in via Supabase failed.');
      }

      return SocialAuthUserModel(
        id: response.user!.id,
        email: response.user!.email ?? account.email,
        name: account.displayName,
        idToken: auth.idToken,
        accessToken: null,
      );
    } on AuthException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      if (e is AppException) rethrow;
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

      if (credential.identityToken == null) {
        throw const AppException(message: 'No Identity Token provided by Apple.');
      }

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: credential.identityToken!,
      );

      if (response.user == null) {
        throw const AppException(message: 'Apple Sign in via Supabase failed.');
      }

      return SocialAuthUserModel(
        id: response.user!.id,
        email: response.user!.email ?? credential.email,
        name: credential.givenName != null
            ? '${credential.givenName} ${credential.familyName}'
            : null,
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
    } on AuthException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }
}
