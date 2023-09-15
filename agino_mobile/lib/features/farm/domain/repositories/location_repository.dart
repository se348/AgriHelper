import '../../../../core/error/failure.dart';
import '../entities/location.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either<Failure, LocationEntity>> getLocation();
}
