import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final String mobile;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.mobile,
  });

  @override
  List<Object> get props => [id, email, firstName, middleName, lastName, mobile];
}
