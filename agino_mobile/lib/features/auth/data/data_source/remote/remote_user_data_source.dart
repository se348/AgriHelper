import '../../models/login_model.dart';
import '../../models/user_model.dart';

abstract class RemoteUserDataSource {
  Future<UserModel> signUp(UserModel user);
  Future<UserModel> login(LoginModel model);
}
