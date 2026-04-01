import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';

class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> checkPermission() async {
    return await localDataSource.checkPermission();
  }

  @override
  Future<bool> requestPermission() async {
    return await localDataSource.requestPermission();
  }

  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    try {
      final position = await localDataSource.getCurrentPosition();
      return Right(LocationEntity(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      return Left(LocationFailure(e.toString()));
    }
  }
}
