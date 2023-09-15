import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/sensor_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sensor_repository.dart';

class CreateSensorUsecase extends UseCase<int, SensorEntity>{
  final SensorRepository sensorRepository;

  CreateSensorUsecase(this.sensorRepository);

  @override
  Future<Either<Failure, int>> call(SensorEntity params) {
    return sensorRepository.createSensor(params);
  }

}