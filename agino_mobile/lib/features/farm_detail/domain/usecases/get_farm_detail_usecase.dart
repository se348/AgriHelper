import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/farm_detail.dart';
import '../repositories/farm_detail_repository.dart';
import 'package:dartz/dartz.dart';

class GetFarmDetailUsercase extends UseCase<FarmDetail, int>{
  
  final FarmDetailRepository farmDetailRepository;

  GetFarmDetailUsercase({required this.farmDetailRepository});

  
  @override
  Future<Either<Failure, FarmDetail>> call(int params) {
    return farmDetailRepository.getFarmDetail(params);
  }

}