import '../../domain/entities/social_auth_user.dart';

class SocialAuthUserModel extends SocialAuthUser {
  const SocialAuthUserModel({
    required super.id,
    super.email,
    super.name,
    super.idToken,
    super.accessToken,
  });

  factory SocialAuthUserModel.fromJson(Map<String, dynamic> json) {
    return SocialAuthUserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      idToken: json['idToken'] as String?,
      accessToken: json['accessToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'idToken': idToken,
      'accessToken': accessToken,
    };
  }
}
