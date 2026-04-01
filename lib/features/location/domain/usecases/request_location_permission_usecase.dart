import '../repositories/location_repository.dart';

class RequestLocationPermissionUseCase {
  final LocationRepository repository;

  RequestLocationPermissionUseCase(this.repository);

  Future<bool> call() async {
    return await repository.requestPermission();
  }
}
