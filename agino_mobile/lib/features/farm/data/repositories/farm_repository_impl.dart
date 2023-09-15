import 'package:dartz/dartz.dart';

import '../../../../core/error/exeption.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/domain/repositories/user_repository.dart';
import '../../domain/entities/farm.dart';
import '../../domain/repositories/farm_repository.dart';
import '../data_source/remote/farm/farm_remote_data_source.dart';
import '../models/farm_model.dart';

class FarmRepositoryImpl extends FarmRepository {
  final UserRepository userRepository;
  final FarmRemoteDataSource farmRemoteDataSource;
  final NetworkInfo networkInfo;
  FarmRepositoryImpl(
      {required this.userRepository,
      required this.farmRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<FarmModel>>> getMyFarms() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "Network Failure"));
    }
    final curr_user = await userRepository.getCachedUser();
    int? curr_user_id;
    curr_user.fold((l) {
      return Left(CacheFailure(message: "No user FOund"));
    }, (r) async {
      if (r.userId == null) {
        return Left(CacheFailure(message: "No user Found"));
      }
      curr_user_id = r.userId;
    });
    try {
      final farms = await farmRemoteDataSource.getMyFarms(curr_user_id!);
      return Right(farms);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure(message: "Serever Failed"));
    }
  }

  @override
  Future<Either<Failure, int>> createFarm(Farm farm) async {
    final farmModel = FarmModel(
        city: farm.city,
        country: farm.country,
        name: farm.name,
        postCode: farm.postCode,
        userId: farm.userId);
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "Network Failure"));
    }
    final curr_user = await userRepository.getCachedUser();
    int? curr_user_id;
    curr_user.fold((l) {
      return Left(CacheFailure(message: "No user FOund"));
    }, (r) async {
      if (r.userId == null) {
        return Left(CacheFailure(message: "No user Found"));
      }
      curr_user_id = r.userId;
    });
    farmModel.userId = curr_user_id;
    try {
      final res = await farmRemoteDataSource.createFarm(farmModel);
      return Right(res);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure(message: "Serever Failed"));
    }
  }
}
