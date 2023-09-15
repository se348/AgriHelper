import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/position_entity.dart';
import '../repositories/position_repository.dart';
import 'package:dartz/dartz.dart';

class GetPositionUsecase extends UseCase<PositionEntity, NoParams> {
  final PositionRepository positionRepository;

  GetPositionUsecase(this.positionRepository);
  @override
  Future<Either<Failure, PositionEntity>> call(NoParams params) async {
    return positionRepository.getLocation();
  }
}
