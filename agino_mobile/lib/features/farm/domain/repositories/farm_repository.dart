import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/farm_model.dart';
import '../entities/farm.dart';

abstract class FarmRepository {
  Future<Either<Failure, List<FarmModel>>> getMyFarms();
  Future<Either<Failure, int>> createFarm(Farm farm);
}
