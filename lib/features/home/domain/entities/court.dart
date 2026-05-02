import 'package:equatable/equatable.dart';

class Court extends Equatable {
  final String id;
  final String name;
  final String type;
  final double price;
  final double rating;
  final double distance;
  final String imageUrl;
  final bool isFeatured;

  const Court({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    required this.isFeatured,
  });

  @override
  List<Object?> get props => [id, name, type, price, rating, distance, imageUrl, isFeatured];
}
