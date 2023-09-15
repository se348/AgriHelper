import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/usecases/get_location_usecase.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<GetLocationEvent, LocationState> {
  final GetLocationUsecase getLocationUsecase;
  LocationBloc(this.getLocationUsecase) : super(LocationIdle()) {
    on<GetLocationEvent>(_onGetLocation);
  }

  Future<void> _onGetLocation(
      GetLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    final res = await getLocationUsecase(NoParams());
    res.fold((l) {
      if (l is ServerFailure) {
        emit(LocationLoadFailed(l.message));
      }
      if (l is NetworkFailure) {
        emit(LocationLoadFailed(l.message));
      }
      if (l is LocationPermissionFailure) {
        emit(LocationLoadFailed(l.message));
      }
    }, (r) {
      emit(LocationLoaded(r));
    });
  }
}
