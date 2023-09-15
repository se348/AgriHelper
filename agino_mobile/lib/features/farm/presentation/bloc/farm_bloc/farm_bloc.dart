import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/farm.dart';
import '../../../domain/usecases/create_farms_usecase.dart';
import '../../../domain/usecases/get_farms_usecase.dart';

part 'farm_event.dart';
part 'farm_state.dart';

class FarmBloc extends Bloc<FarmEvent, FarmState> {
  final GetFarmUseCase getFarmUseCase;
  final CreateFarmUsecase createFarmUsecase;
  var farms = <Farm>[];
  FarmBloc({required this.getFarmUseCase, required this.createFarmUsecase})
      : super(FarmIdle()) {
    on<GetAllFarms>(_onGetAllFarms);
    on<CreateFarm>(_onCreateFarm);
  }

  Future<void> _onGetAllFarms(
      GetAllFarms event, Emitter<FarmState> emit) async {
    emit(FarmLoading());
    final res = await getFarmUseCase(NoParams());
    res.fold((l) {
      if (l is NetworkFailure) {
        return emit(FarmLoadingFailure("Network Failure"));
      } else if (l is UnauthorizedFailure) {
        return emit(FarmLoadingFailure("Unauthorized Failure"));
      } else if (l is CacheFailure) {
        return emit(FarmLoadingFailure("No user Found"));
      }
      return emit(FarmLoadingFailure("Server failed"));
    }, (r) {
      farms = r;
      return emit(MyFarmsLoaded(farms));
    });
  }

  Future<void> _onCreateFarm(CreateFarm event, Emitter<FarmState> emit) async {
    emit(FarmLoading());

    final res = await createFarmUsecase(event.farm);
    print(res);
    res.fold((l) {
      if (res is NetworkFailure) {
        emit(FarmLoadingFailure("Network Failure"));
      } else if (res is UnauthorizedFailure) {
        emit(FarmLoadingFailure("Unauthorized Failure"));
      } else if (res is CacheFailure) {
        emit(FarmLoadingFailure("No user Found"));
      } else {
        emit(FarmLoadingFailure("Server failed"));
      }
    }, (r) => emit(FarmCreatedSuccessful(r)));
  }
}
