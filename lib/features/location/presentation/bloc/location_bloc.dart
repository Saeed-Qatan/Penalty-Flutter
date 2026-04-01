import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_location_permission_usecase.dart';
import '../../domain/usecases/request_location_permission_usecase.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final CheckLocationPermissionUseCase checkLocationPermission;
  final RequestLocationPermissionUseCase requestLocationPermission;
  final GetCurrentLocationUseCase getCurrentLocation;

  LocationBloc({
    required this.checkLocationPermission,
    required this.requestLocationPermission,
    required this.getCurrentLocation,
  }) : super(LocationInitial()) {
    on<CheckLocationPermissionEvent>(_onCheckPermission);
    on<RequestLocationPermissionEvent>(_onRequestPermission);
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
  }

  Future<void> _onCheckPermission(
    CheckLocationPermissionEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final granted = await checkLocationPermission();
    if (granted) {
      emit(LocationPermissionGranted());
    } else {
      emit(const LocationPermissionDenied());
    }
  }

  Future<void> _onRequestPermission(
    RequestLocationPermissionEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final granted = await requestLocationPermission();
    if (granted) {
      emit(LocationPermissionGranted());
    } else {
      emit(const LocationPermissionDenied(
        message: 'Location permission was denied. You can enable it later in Settings.',
      ));
    }
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final result = await getCurrentLocation();
    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (location) => emit(LocationLoaded(location)),
    );
  }
}
