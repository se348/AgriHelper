import '../../models/user_model.dart';

abstract class LocalUserDataSource {
  Future<UserModel> getCachedUser();
  Future<int> cacheUser(UserModel user);
  Future<bool> logout();
}
