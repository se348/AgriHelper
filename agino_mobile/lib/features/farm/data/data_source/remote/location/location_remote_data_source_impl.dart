import 'package:dio/dio.dart';

import '../../../../../../core/error/exeption.dart';
import '../../../models/location_model.dart';
import 'location_remote_data_source.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final Dio dio;
  LocationRemoteDataSourceImpl({required this.dio});

  @override
  Future<LocationModel> getLocationInformation(
      double latitude, double longitude) async {
    final String url =
        "https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json";
    try {
      final response = await dio.get(url);
      return LocationModel.fromJson(response.data);
    } on DioException {
      throw const ServerException();
    }
  }
}
