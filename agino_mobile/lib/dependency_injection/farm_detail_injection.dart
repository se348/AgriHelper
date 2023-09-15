import '../features/farm_detail/data/data_source/farm_detail_remote_data_source.dart';
import '../features/farm_detail/data/data_source/farm_detail_remote_data_source_impl.dart';
import '../features/farm_detail/data/repositories/farm_detail_repository_impl.dart';
import '../features/farm_detail/domain/repositories/farm_detail_repository.dart';
import '../features/farm_detail/domain/usecases/get_farm_detail_usecase.dart';
import 'package:get_it/get_it.dart';

import '../features/farm_detail/presentation/bloc/farm_detail_bloc.dart';

void farmDetailInjection(GetIt sl) {
  sl.registerFactory(() => FarmDetailBloc(
        getFarmDetailUsercase: sl(),
      ));

  sl.registerLazySingleton(
      () => GetFarmDetailUsercase(farmDetailRepository: sl()));

  sl.registerLazySingleton<FarmDetailRepository>(() => FarmDetailRepositoryImpl(
      farmDetailRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FarmDetailRemoteDataSource>(
      () => FarmDetailRemoteDataSourceImpl(sl()));
}
