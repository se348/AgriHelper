import '../../../../core/error/exeption.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../data_source/remote/location/location_remote_data_source.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl extends LocationRepository {
  LocationRemoteDataSource locationRemoteDataSource;
  NetworkInfo networkInfo;

  LocationRepositoryImpl(
      {required this.locationRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, LocationEntity>> getLocation() async {
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
    try {
      final model = await locationRemoteDataSource.getLocationInformation(
          position.latitude, position.longitude);
      return Right(model);
    } on ServerException {
      return Left(ServerFailure(message: "Unexpected error"));
    }
  }
}
