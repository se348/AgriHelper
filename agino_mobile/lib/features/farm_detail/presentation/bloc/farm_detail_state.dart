part of 'farm_detail_bloc.dart';

abstract class FarmDetailState extends Equatable {}

class FarmDetailIdle extends FarmDetailState {
  @override
  List<Object?> get props => [];
}

class FarmDetailLoading extends FarmDetailState {
  @override
  List<Object?> get props => [];
}

class FarmDetailLoaded extends FarmDetailState {
  final FarmDetail farmDetail;

  FarmDetailLoaded({required this.farmDetail});

  @override
  List<Object?> get props => [farmDetail];
}

class FarmLoadingFailed extends FarmDetailState {
  @override
  List<Object?> get props => [];
}
