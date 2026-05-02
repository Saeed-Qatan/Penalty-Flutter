import '../models/court_model.dart';
import '../models/promotion_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PromotionModel>> getPromotions();
  Future<List<CourtModel>> getNearbyCourts();
  Future<List<CourtModel>> getFeaturedCourts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<PromotionModel>> getPromotions() async {
    await Future.delayed(const Duration(seconds: 1)); // Mock network delay
    return const [
      PromotionModel(
        id: '1',
        title: 'خصم ٥٠٪\nعلى ملاعب كرة القدم',
        discountText: 'عرض خاص 🔥',
        imageUrl: 'https://picsum.photos/600/400?random=1',
      ),
    ];
  }

  @override
  Future<List<CourtModel>> getNearbyCourts() async {
    await Future.delayed(const Duration(seconds: 1));
    return const [
      CourtModel(
        id: 'c1',
        name: 'ملاعب الجوهرة',
        type: 'خماسي',
        price: 250,
        rating: 4.8,
        distance: 2.5,
        imageUrl: 'https://picsum.photos/600/400?random=2',
        isFeatured: false,
      ),
      CourtModel(
        id: 'c2',
        name: 'ستاد المدينة',
        type: 'سداسي',
        price: 300,
        rating: 4.9,
        distance: 4.0,
        imageUrl: 'https://picsum.photos/600/400?random=3',
        isFeatured: false,
      ),
    ];
  }

  @override
  Future<List<CourtModel>> getFeaturedCourts() async {
    await Future.delayed(const Duration(seconds: 1));
    return const [
      CourtModel(
        id: 'f1',
        name: 'ملعب المحترفين',
        type: 'خماسي',
        price: 150,
        rating: 4.5,
        distance: 3.2,
        imageUrl: 'https://picsum.photos/600/400?random=4',
        isFeatured: true,
      ),
    ];
  }
}
