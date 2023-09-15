import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/repositories/position_repository.dart';

class PositionRepositoryImpl extends PositionRepository {
  final NetworkInfo networkInfo;

  PositionRepositoryImpl({required this.networkInfo});

  @override
  Future<Either<Failure, PositionEntity>> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(
          message: "Check your internet connection and try again"));
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const Left(LocationPermissionFailure(
          message: "Location services are disabled."));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left(LocationPermissionFailure(
            message: "Location services are disabled."));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const Left(LocationPermissionFailure(
          message:
              "Location services are disable, we cannot request permissions."));
    }

    Position position = await Geolocator.getCurrentPosition();
    final positionEntity = PositionEntity(
        latitude: position.latitude, longitude: position.longitude);
    return Right(positionEntity);
  }
}
