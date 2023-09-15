import '../entities/farm.dart';
import '../repositories/farm_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetFarmUseCase extends UseCase<List<Farm>, NoParams> {
  final FarmRepository farmRepository;

  GetFarmUseCase({required this.farmRepository});

  @override
  Future<Either<Failure, List<Farm>>> call(NoParams params) {
    return farmRepository.getMyFarms();
  }
}
