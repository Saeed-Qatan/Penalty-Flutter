import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/court.dart';
import '../entities/promotion.dart';
import '../repositories/home_repository.dart';

class HomeData {
  final List<Promotion> promotions;
  final List<Court> nearbyCourts;
  final List<Court> featuredCourts;

  HomeData({
    required this.promotions,
    required this.nearbyCourts,
    required this.featuredCourts,
  });
}

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, HomeData>> call() async {
    Failure? failure;
    List<Promotion>? promotions;
    List<Court>? nearbyCourts;
    List<Court>? featuredCourts;

    final promoRes = await repository.getPromotions();
    promoRes.fold((l) => failure = l, (r) => promotions = r);
    if (failure != null) return Left(failure!);

    final nearbyRes = await repository.getNearbyCourts();
    nearbyRes.fold((l) => failure = l, (r) => nearbyCourts = r);
    if (failure != null) return Left(failure!);

    final featuredRes = await repository.getFeaturedCourts();
    featuredRes.fold((l) => failure = l, (r) => featuredCourts = r);
    if (failure != null) return Left(failure!);

    return Right(HomeData(
      promotions: promotions!,
      nearbyCourts: nearbyCourts!,
      featuredCourts: featuredCourts!,
    ));
  }
}
