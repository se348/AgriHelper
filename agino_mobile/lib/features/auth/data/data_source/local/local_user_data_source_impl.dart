import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exeption.dart';
import '../../models/user_model.dart';
import 'local_user_data_source.dart';

class LocalUserDataSourceImpl extends LocalUserDataSource {
  final SharedPreferences sharedPreferences;

  LocalUserDataSourceImpl({required this.sharedPreferences});
  final key = "CURR_USER";
  @override
  Future<int> cacheUser(UserModel user) async {
    try {
      var encoded = json.encode(user.toJson());
      print(encoded);
      await sharedPreferences.setString(key, encoded);
      return 1;
    } catch (err) {
      throw const CacheException();
    }
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final encoded = sharedPreferences.getString(key);
      if (encoded == null) {
        throw const CacheException();
      }
      return UserModel.fromJson(json.decode(encoded));
    } catch (err) {
      throw const CacheException();
    }
  }

  @override
  Future<bool> logout() async {
    return await sharedPreferences.remove(key);
  }
}
