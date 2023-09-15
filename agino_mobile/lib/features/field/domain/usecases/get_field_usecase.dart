import '../entities/field_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/field_repository.dart';

class GetFieldUsecase implements UseCase<FieldEntity, int> {
  final FieldRepository fieldRepository;

  GetFieldUsecase(this.fieldRepository);

  @override
  Future<Either<Failure, FieldEntity>> call(int fieldId) {
    return fieldRepository.getField(fieldId);
  }
}