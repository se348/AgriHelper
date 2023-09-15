import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exeption.dart';
import '../models/sensor_model.dart';
import 'sensor_remote_data_source.dart';

class SensorRemoteDataSourceImpl extends SensorRemoteDataSource {
  final Dio dio;

  SensorRemoteDataSourceImpl(this.dio);

  @override
  Future<int> createSensor(SensorModel sensorModel) async {
    final url = '${apiBaseUrl}Sensor';
    try {
      print(sensorModel.toJson());
      final response = await dio.post(url, data: sensorModel.toJson());
      return response.data["value"];
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw const ServerException();
    }
  }
}
