import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/court.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Promotion>>> getPromotions() async {
    try {
      final remotePromotions = await remoteDataSource.getPromotions();
      return Right(remotePromotions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Court>>> getNearbyCourts() async {
    try {
      final remoteCourts = await remoteDataSource.getNearbyCourts();
      return Right(remoteCourts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Court>>> getFeaturedCourts() async {
    try {
      final remoteCourts = await remoteDataSource.getFeaturedCourts();
      return Right(remoteCourts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
