part of 'farm_detail_bloc.dart';

abstract class FarmDetailEvent extends Equatable {}

class GetFarmDetail extends FarmDetailEvent {
  final int farmId;

  GetFarmDetail(this.farmId);
  @override
  List<Object?> get props => [farmId];
}
