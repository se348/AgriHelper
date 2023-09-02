import 'package:agino_mobile/core/error/exeption.dart';
import 'package:agino_mobile/core/error/failure.dart';
import 'package:agino_mobile/features/auth/data/data_source/local/local_user_data_source.dart';
import 'package:agino_mobile/features/auth/data/models/user_model.dart';
import 'package:agino_mobile/features/auth/domain/entities/user.dart';
import 'package:agino_mobile/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDataSource localUserDataSource;

  UserRepositoryImpl({required this.localUserDataSource});

  @override
  Future<Either<Failure, int>> cacheUser(User user) async {
    try {
      UserModel mapped = UserModel(
          email: user.email,
          password: user.password,
          phone: user.phone,
          name: user.name,
          userId: user.userId);
      await localUserDataSource.cacheUser(mapped);
      return const Right(1);
    } on CacheException {
      return Left(CacheFailure(message: "Caching error"));
    }
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      var res = await localUserDataSource.getCachedUser();
      return Right(res);
    } on CacheException {
      return Left(CacheFailure(message: "No user found"));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(User user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
