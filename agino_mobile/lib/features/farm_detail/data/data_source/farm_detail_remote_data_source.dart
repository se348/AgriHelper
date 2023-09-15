import '../models/farm_detail_model.dart';

abstract class FarmDetailRemoteDataSource {
  Future<FarmDetailModel> getFarmDetail(int farmId);
}
