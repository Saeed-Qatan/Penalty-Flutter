import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'],
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'mobile': mobile,
    };
  }
}
