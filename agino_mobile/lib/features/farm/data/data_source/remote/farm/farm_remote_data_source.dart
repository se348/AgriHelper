import '../../../models/farm_model.dart';

abstract class FarmRemoteDataSource {
  Future<List<FarmModel>> getMyFarms(int userId);
  Future<int> createFarm(FarmModel farmModel);
}
