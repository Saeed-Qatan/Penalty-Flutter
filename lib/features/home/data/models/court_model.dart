import '../../domain/entities/court.dart';

class CourtModel extends Court {
  const CourtModel({
    required super.id,
    required super.name,
    required super.type,
    required super.price,
    required super.rating,
    required super.distance,
    required super.imageUrl,
    required super.isFeatured,
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    return CourtModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'price': price,
      'rating': rating,
      'distance': distance,
      'image_url': imageUrl,
      'is_featured': isFeatured,
    };
  }
}
