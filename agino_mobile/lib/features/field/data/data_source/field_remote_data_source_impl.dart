import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exeption.dart';
import '../models/field_model.dart';
import 'field_remote_data_source.dart';

class FieldRemoteDataSourceImpl extends FieldRemoteDataSource {
  final Dio dio;

  FieldRemoteDataSourceImpl(this.dio);

  @override
  Future<int> createField(FieldModel fieldModel) async {
    final url = '${apiBaseUrl}Field';
    try {
      final response = await dio.post(url, data: fieldModel.toJson());
      return response.data["value"];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw const ServerException();
    }
  }

  @override
  Future<FieldModel> getField(int fieldId) async {
    final url = '${apiBaseUrl}Field/$fieldId/WithSensors';
    try {
      final res = await dio.get(url);
      return FieldModel.fromJson(res.data["value"]);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw const ServerException();
    }
  }
}
