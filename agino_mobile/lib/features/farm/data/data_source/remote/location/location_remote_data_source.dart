import '../../../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> getLocationInformation(
      double latitude, double longitude);
}
