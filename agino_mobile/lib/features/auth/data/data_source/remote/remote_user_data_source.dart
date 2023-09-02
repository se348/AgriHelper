import '../../models/user_model.dart';

abstract class RemoteUserDataSource {
  Future<int> signUp(UserModel user);
}
