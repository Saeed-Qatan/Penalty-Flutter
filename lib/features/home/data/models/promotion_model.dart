import '../../domain/entities/promotion.dart';

class PromotionModel extends Promotion {
  const PromotionModel({
    required super.id,
    required super.title,
    required super.discountText,
    required super.imageUrl,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      discountText: json['discount_text'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'discount_text': discountText,
      'image_url': imageUrl,
    };
  }
}
