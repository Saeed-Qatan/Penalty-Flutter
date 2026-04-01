import 'package:get_it/get_it.dart';
import 'features/location/data/datasources/location_local_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/check_location_permission_usecase.dart';
import 'features/location/domain/usecases/request_location_permission_usecase.dart';
import 'features/location/domain/usecases/get_current_location_usecase.dart';
import 'features/location/presentation/bloc/location_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Location Feature ──

  // BLoC
  sl.registerFactory(
    () => LocationBloc(
      checkLocationPermission: sl(),
      requestLocationPermission: sl(),
      getCurrentLocation: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => CheckLocationPermissionUseCase(sl()));
  sl.registerLazySingleton(() => RequestLocationPermissionUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentLocationUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(),
  );
}
