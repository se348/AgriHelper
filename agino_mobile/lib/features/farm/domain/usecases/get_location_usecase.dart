import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class GetLocationUsecase extends UseCase<LocationEntity, NoParams> {
  final LocationRepository locationRepository;

  GetLocationUsecase({required this.locationRepository});

  @override
  Future<Either<Failure, LocationEntity>> call(NoParams params) {
    return locationRepository.getLocation();
  }
}
