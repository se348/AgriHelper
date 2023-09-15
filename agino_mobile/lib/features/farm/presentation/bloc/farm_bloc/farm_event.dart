part of 'farm_bloc.dart';

abstract class FarmEvent extends Equatable {}

class GetAllFarms extends FarmEvent {
  @override
  List<Object?> get props => [];
}

class CreateFarm extends FarmEvent {
  final Farm farm;

  CreateFarm(this.farm);
  @override
  List<Object?> get props => [farm];
}

