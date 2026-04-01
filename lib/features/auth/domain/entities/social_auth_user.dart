import 'package:equatable/equatable.dart';

class SocialAuthUser extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? idToken;
  final String? accessToken;

  const SocialAuthUser({
    required this.id,
    this.email,
    this.name,
    this.idToken,
    this.accessToken,
  });

  @override
  List<Object?> get props => [id, email, name, idToken, accessToken];
}
