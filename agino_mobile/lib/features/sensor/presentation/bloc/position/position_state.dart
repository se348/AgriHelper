part of 'position_bloc.dart';

abstract class PositionState extends Equatable {}

class PositionGotSuccessfully extends PositionState {
  final PositionEntity positionEntity;

  PositionGotSuccessfully(this.positionEntity);
  @override
  List<Object?> get props => [positionEntity];
}

class PositionFailed extends PositionState {
  @override
  List<Object?> get props => [];
}

class PositionLoading extends PositionState {
  @override
  List<Object?> get props => [];
}

class PositionIdle extends PositionState {
  @override
  List<Object?> get props => [];
}
