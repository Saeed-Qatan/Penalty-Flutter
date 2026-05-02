import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  final String id;
  final String title;
  final String discountText;
  final String imageUrl;

  const Promotion({
    required this.id,
    required this.title,
    required this.discountText,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, discountText, imageUrl];
}
