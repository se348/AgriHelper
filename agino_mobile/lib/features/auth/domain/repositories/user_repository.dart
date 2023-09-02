import 'package:agino_mobile/core/error/failure.dart';
import 'package:agino_mobile/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCachedUser();
  Future<Either<Failure, int>> cacheUser(User user);

  Future<Either<Failure, User>> signUp(User user);
}
