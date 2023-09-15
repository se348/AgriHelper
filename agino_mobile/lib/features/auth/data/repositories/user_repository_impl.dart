import '../../../../core/error/exeption.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../data_source/local/local_user_data_source.dart';
import '../data_source/remote/remote_user_data_source.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDataSource localUserDataSource;
  final RemoteUserDataSource remoteUserDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.networkInfo,
      required this.remoteUserDataSource,
      required this.localUserDataSource});

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
     if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "No Internet connection"));
    }
    try {
      var res = await localUserDataSource.getCachedUser();
      return Right(res);
    } on CacheException {
      return Left(CacheFailure(message: "No user found"));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(User user) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "No Internet connection"));
    }

    try {
      UserModel mapped = UserModel(
          email: user.email,
          password: user.password,
          phone: user.phone,
          name: user.name,
          userId: user.userId);
      final returned = await remoteUserDataSource.signUp(mapped);
      await localUserDataSource.cacheUser(returned);
      return Right(returned);
    } on SignUpException {
      return Left(SignUpFailure(message: "Signup failure"));
    } on ServerException {
      return Left(ServerFailure(message: "Server exception"));
    } on CacheException {
      return Left(CacheFailure(message: "Caching Failed"));
    }
  }

  @override
  Future<Either<Failure, User>> login(LoginEntity user) async {
    try {
      final model = LoginModel(email: user.email, password: user.password);
      final returned = await remoteUserDataSource.login(model);
      await localUserDataSource.cacheUser(returned);
      return Right(returned);
    } on LoginException catch (e) {
      return Left(SignUpFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure(message: "Server exception"));
    } on CacheException {
      return Left(CacheFailure(message: "Caching Failed"));
    }
  }
  
  @override
  Future<bool> logout() {
    return localUserDataSource.logout();
  }
}
