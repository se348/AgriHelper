import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/farm_detail.dart';
import '../../domain/usecases/get_farm_detail_usecase.dart';

part 'farm_detail_event.dart';
part 'farm_detail_state.dart';

class FarmDetailBloc extends Bloc<FarmDetailEvent, FarmDetailState> {
  final GetFarmDetailUsercase getFarmDetailUsercase;

  FarmDetailBloc({required this.getFarmDetailUsercase})
      : super(FarmDetailIdle()) {
    on<GetFarmDetail>(_onGetFarmDetail);
  }

  Future<void> _onGetFarmDetail(
      GetFarmDetail getFarmDetail, Emitter<FarmDetailState> emit) async {
    emit(FarmDetailLoading());

    final res = await getFarmDetailUsercase(getFarmDetail.farmId);
    res.fold((l) {
      return emit(FarmLoadingFailed());
    }, (r) {
      return emit(FarmDetailLoaded(farmDetail: r));
    });
  }
}
