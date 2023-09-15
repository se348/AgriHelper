import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/field_entity.dart';
import '../repositories/field_repository.dart';
import 'package:dartz/dartz.dart';

class CreateFieldUsecase implements UseCase<int, FieldEntity> {
  final FieldRepository fieldRepository;

  CreateFieldUsecase(this.fieldRepository);

  @override
  Future<Either<Failure, int>> call(FieldEntity field) {
    return fieldRepository.createField(field);
  }
}
