part of 'location_bloc.dart';

abstract class LocationState extends Equatable {}

class LocationLoaded extends LocationState {
  final LocationEntity locationEntity;

  LocationLoaded(this.locationEntity);

  @override
  List<Object?> get props => [locationEntity];
}

class LocationIdle extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationLoadFailed extends LocationState {
  final String message;

  LocationLoadFailed(this.message);
  @override
  List<Object?> get props => [message];
}
