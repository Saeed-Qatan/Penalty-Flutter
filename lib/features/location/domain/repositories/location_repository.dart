import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<bool> checkPermission();
  Future<bool> requestPermission();
  Future<Either<Failure, LocationEntity>> getCurrentLocation();
}
