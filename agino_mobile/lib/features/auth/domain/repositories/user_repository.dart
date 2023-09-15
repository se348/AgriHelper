import '../../../../core/error/failure.dart';
import '../entities/login_entity.dart';
import '../entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCachedUser();
  Future<Either<Failure, int>> cacheUser(User user);

  Future<Either<Failure, User>> signUp(User user);
  Future<Either<Failure, User>> login(LoginEntity user);

  Future<bool> logout();

}
