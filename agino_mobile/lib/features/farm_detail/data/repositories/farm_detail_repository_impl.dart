import 'package:dartz/dartz.dart';

import '../../../../core/error/exeption.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/farm_detail.dart';
import '../../domain/repositories/farm_detail_repository.dart';
import '../data_source/farm_detail_remote_data_source.dart';

class FarmDetailRepositoryImpl extends FarmDetailRepository {
  final FarmDetailRemoteDataSource farmDetailRemoteDataSource;
  final NetworkInfo networkInfo;
  FarmDetailRepositoryImpl(
      {required this.farmDetailRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, FarmDetail>> getFarmDetail(int farmId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "Network Failure"));
    }
    try {
      final farms = await farmDetailRemoteDataSource.getFarmDetail(farmId);
      return Right(farms);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure(message: "Serever Failed"));
    }
  }
}
