import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/farm_detail.dart';

abstract class FarmDetailRepository{
  Future<Either<Failure, FarmDetail>> getFarmDetail(int farmId);
}