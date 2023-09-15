part of 'farm_bloc.dart';

abstract class FarmState extends Equatable {}

class FarmIdle extends FarmState {
  @override
  List<Object?> get props => [];
}

class FarmLoading extends FarmState {
  @override
  List<Object?> get props => [];
}

class FarmLoadingFailure extends FarmState {
  final String message;

  FarmLoadingFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class MyFarmsLoaded extends FarmState {
  final List<Farm> farms;

  MyFarmsLoaded(this.farms);
  @override
  List<Object?> get props => [farms];
}

class FarmCreatedSuccessful extends FarmState {
  final int farmId;
  FarmCreatedSuccessful(this.farmId);
  @override
  List<Object?> get props => [farmId];
}
