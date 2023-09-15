import '../features/farm/domain/usecases/get_location_usecase.dart';
import 'package:get_it/get_it.dart';

import '../features/farm/data/data_source/remote/location/location_remote_data_source.dart';
import '../features/farm/data/data_source/remote/location/location_remote_data_source_impl.dart';
import '../features/farm/data/repositories/location_repository_impl.dart';
import '../features/farm/domain/repositories/location_repository.dart';
import '../features/farm/presentation/bloc/location_bloc/location_bloc.dart';

void locationInjection(GetIt sl){
   sl.registerFactory(() => LocationBloc(sl()));

  sl.registerLazySingleton(() => GetLocationUsecase(locationRepository: sl()));

  sl.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(
      locationRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl(dio: sl()));
}