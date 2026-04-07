import 'package:get_it/get_it.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/presentation/bloc/forgot_password_bloc.dart';
import 'features/auth/presentation/bloc/sign_in_bloc.dart';
import 'features/auth/presentation/bloc/sign_up_bloc.dart';
import 'features/auth/presentation/bloc/verify_otp/verify_otp_bloc.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';
import 'features/location/data/datasources/location_local_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/check_location_permission_usecase.dart';
import 'features/location/domain/usecases/request_location_permission_usecase.dart';
import 'features/location/domain/usecases/get_current_location_usecase.dart';
import 'features/location/presentation/bloc/location_bloc.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

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

  // ── Auth Feature ──

  // BLoC
  sl.registerFactory(
    () => SignInBloc(
      signInUseCase: sl(),
      signInWithGoogleUseCase: sl(),
      signInWithAppleUseCase: sl(),
    ),
  );
  sl.registerFactory(() => SignUpBloc(signUpUseCase: sl()));
  sl.registerFactory(() => ForgotPasswordBloc(forgotPasswordUseCase: sl()));
  sl.registerFactory(
    () => VerifyOtpBloc(
      verifyOtpUseCase: sl(),
      forgotPasswordUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithAppleUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Supabase
  sl.registerLazySingleton(() => Supabase.instance.client);

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: sl()),
  );
}
