import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class CheckLocationPermissionEvent extends LocationEvent {}

class RequestLocationPermissionEvent extends LocationEvent {}

class GetCurrentLocationEvent extends LocationEvent {}
