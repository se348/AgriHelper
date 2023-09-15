import 'package:dartz/dartz.dart';

import '../../../../core/error/exeption.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sensor_entity.dart';
import '../../domain/repositories/sensor_repository.dart';
import '../data_sources/sensor_remote_data_source.dart';
import '../models/sensor_model.dart';

class SensorRepositoryImpl extends SensorRepository {
  final SensorRemoteDataSource sensorRemoteDataSource;
  final NetworkInfo networkInfo;

  SensorRepositoryImpl(this.sensorRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, int>> createSensor(SensorEntity sensorEntity) async {
    final sensorModel = SensorModel(
        fieldId: sensorEntity.fieldId,
        serialNumber: sensorEntity.serialNumber,
        batteryStatus: sensorEntity.batteryStatus,
        optimalGdd: sensorEntity.optimalGdd,
        cuttingDateCalculated: sensorEntity.cuttingDateCalculated,
        latitude: sensorEntity.latitude,
        longitude: sensorEntity.longitude,
        sensorId: sensorEntity.sensorId,
        lastCommunication: sensorEntity.lastCommunication,
        lastForecastDate: sensorEntity.lastForecastDate,
        baseTemp: sensorEntity.baseTemp,
        state: sensorEntity.state);

    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "Network Failure"));
    }

    try {
      final res = await sensorRemoteDataSource.createSensor(sensorModel);
      return Right(res);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure(message: "Serever Failed"));
    }
  }
}
