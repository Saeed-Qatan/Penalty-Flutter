import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/court.dart';
import '../entities/promotion.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Promotion>>> getPromotions();
  Future<Either<Failure, List<Court>>> getNearbyCourts();
  Future<Either<Failure, List<Court>>> getFeaturedCourts();
}
