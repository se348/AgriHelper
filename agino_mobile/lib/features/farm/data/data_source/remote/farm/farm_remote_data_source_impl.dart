import 'package:dio/dio.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/error/exeption.dart';
import '../../../models/farm_model.dart';
import 'farm_remote_data_source.dart';

class FarmRemoteDataSourceImpl extends FarmRemoteDataSource {
  final Dio dio;

  FarmRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<FarmModel>> getMyFarms(int userId) async {
    final url = '${apiBaseUrl}User/MyFarms?UserId=$userId';
    try {
      final response = await dio.get(url);
      List<FarmModel> list = [];
      for (var item in response.data["value"]) {
        list.add(FarmModel.fromJson(item));
      }
      return list;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw const ServerException();
    }
  }

  @override
  Future<int> createFarm(FarmModel farmModel) async {
    final url = '${apiBaseUrl}Farm';
    try {
      final response = await dio.post(url, data: farmModel.toJson());
      return response.data["value"];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw const ServerException();
    }
  }
}
