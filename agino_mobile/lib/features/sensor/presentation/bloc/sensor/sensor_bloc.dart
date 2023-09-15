import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/sensor_entity.dart';
import '../../../domain/usecases/create_sensor_usecase.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final CreateSensorUsecase createSensorUsecase;

  SensorBloc({required this.createSensorUsecase}) : super(SensorIdle()) {
    on<CreateSensorEvent>(_onCreateSensorEvent);
  }

  Future<void> _onCreateSensorEvent(
      CreateSensorEvent createSensorEvent, Emitter<SensorState> emit) async {
    emit(SensorLoading());

    final res = await createSensorUsecase(createSensorEvent.sensorEntity);

    res.fold((l) {
      return emit(SensorFailed());
    }, (r) {
      return emit(SensorCreatedSuccessfully(r));
    });
  }
}
