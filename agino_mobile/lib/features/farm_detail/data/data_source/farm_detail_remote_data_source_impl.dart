import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exeption.dart';
import '../models/farm_detail_model.dart';
import 'farm_detail_remote_data_source.dart';

class FarmDetailRemoteDataSourceImpl extends FarmDetailRemoteDataSource {
  final Dio dio;

  FarmDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<FarmDetailModel> getFarmDetail(int farmId) async {
    final url = '${apiBaseUrl}Farm/$farmId';
    try {
      final response = await dio.get(url);

      return FarmDetailModel.fromJson(response.data["value"]);
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw const ServerException();
    }
  }
}
