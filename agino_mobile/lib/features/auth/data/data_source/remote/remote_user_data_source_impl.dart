import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exeption.dart';
import '../../models/login_model.dart';
import '../../models/user_model.dart';
import 'remote_user_data_source.dart';

class RemoteUserDataSourceImpl extends RemoteUserDataSource {
  final Dio dio;
  RemoteUserDataSourceImpl({
    required this.dio,
  });

  @override
  Future<UserModel> signUp(UserModel user) async {
    try {
      final response =
          await dio.post('${apiBaseUrl}User', data: jsonEncode(user.toJson()));
      final responseBody = response.data;
      return UserModel.fromJson(responseBody['value']);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode! > 399 && e.response!.statusCode! < 500) {
          throw const SignUpException();
        }
      }
      throw const ServerException();
    }
  }

  @override
  Future<UserModel> login(LoginModel model) async {
     try {
      final response =
          await dio.post('${apiBaseUrl}User/Login', data: jsonEncode(model.toJson()));
      final responseBody = response.data;
      return UserModel.fromJson(responseBody['value']);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode! > 399 && e.response!.statusCode! < 500) {
          throw const LoginException();
        }
      }
      throw const ServerException();
    }
  }
}
