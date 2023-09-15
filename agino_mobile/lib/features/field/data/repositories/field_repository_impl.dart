import '../data_source/field_remote_data_source.dart';
import '../models/field_model.dart';
import '../../domain/entities/field_entity.dart';
import '../../domain/repositories/field_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exeption.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class FieldRepositoryImpl extends FieldRepository {
  final FieldRemoteDataSource fieldRemoteDataSource;
  final NetworkInfo networkInfo;
  FieldRepositoryImpl(
      {required this.fieldRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, int>> createField(FieldEntity field) async {
    final fieldModel = FieldModel(
      fieldId: field.fieldId,
      polygon: field.polygon,
      altitude: field.altitude,
      farmId: field.farmId,
    );
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "Network Failure"));
    }

    try {
      final res = await fieldRemoteDataSource.createField(fieldModel);
      return Right(res);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure(message: "Serever Failed"));
    }
  }
  
  @override
  Future<Either<Failure, FieldEntity>> getField(int fieldId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(message: "Network Failure"));
    }
     try {
      final res = await fieldRemoteDataSource.getField(fieldId);
      return Right(res);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ServerException {
      return Left(ServerFailure(message: "Serever Failed"));
    }
  }
}
