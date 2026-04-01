import '../repositories/location_repository.dart';

class CheckLocationPermissionUseCase {
  final LocationRepository repository;

  CheckLocationPermissionUseCase(this.repository);

  Future<bool> call() async {
    return await repository.checkPermission();
  }
}
