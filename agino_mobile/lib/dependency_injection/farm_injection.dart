import 'package:get_it/get_it.dart';

import '../features/farm/data/data_source/remote/farm/farm_remote_data_source.dart';
import '../features/farm/data/data_source/remote/farm/farm_remote_data_source_impl.dart';
import '../features/farm/data/repositories/farm_repository_impl.dart';
import '../features/farm/domain/repositories/farm_repository.dart';
import '../features/farm/domain/usecases/create_farms_usecase.dart';
import '../features/farm/domain/usecases/get_farms_usecase.dart';
import '../features/farm/presentation/bloc/farm_bloc/farm_bloc.dart';

void farmInjection(GetIt sl){
  
  sl.registerFactory(
      () => FarmBloc(getFarmUseCase: sl(), createFarmUsecase: sl()));

  sl.registerLazySingleton(() => GetFarmUseCase(farmRepository: sl()));
  sl.registerLazySingleton(() => CreateFarmUsecase(farmRepository: sl()));

  sl.registerLazySingleton<FarmRepository>(() => FarmRepositoryImpl(
      farmRemoteDataSource: sl(), userRepository: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FarmRemoteDataSource>(
      () => FarmRemoteDataSourceImpl(dio: sl()));

}