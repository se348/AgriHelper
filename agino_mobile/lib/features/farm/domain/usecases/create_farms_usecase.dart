import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/farm.dart';
import '../repositories/farm_repository.dart';

class CreateFarmUsecase extends UseCase<int, Farm> {
  final FarmRepository farmRepository;

  CreateFarmUsecase({required this.farmRepository});

  @override
  Future<Either<Failure, int>> call(Farm farm) async {
    return farmRepository.createFarm(farm);
  }
}
