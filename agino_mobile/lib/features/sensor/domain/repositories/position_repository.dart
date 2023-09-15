import '../entities/position_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class PositionRepository {
  Future<Either<Failure, PositionEntity>> getLocation();
}
