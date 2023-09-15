import '../../../../core/error/failure.dart';
import '../entities/sensor_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SensorRepository{
  Future<Either<Failure, int>> createSensor(SensorEntity sensorEntity);
}