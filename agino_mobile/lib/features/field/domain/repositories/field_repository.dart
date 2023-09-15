import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/field_entity.dart';

abstract class FieldRepository {
  Future<Either<Failure, int>> createField(FieldEntity field);
  Future<Either<Failure, FieldEntity>> getField(int fieldId);
}
