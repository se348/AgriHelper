import '../models/sensor_model.dart';

abstract class SensorRemoteDataSource {
  Future<int> createSensor(SensorModel sensorModel);
}
