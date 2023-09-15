import 'package:get_it/get_it.dart';

import '../features/sensor/data/data_sources/sensor_remote_data_source.dart';
import '../features/sensor/data/data_sources/sensor_remote_data_source_impl.dart';
import '../features/sensor/data/repositories/sensor_repository_impl.dart';
import '../features/sensor/domain/repositories/sensor_repository.dart';
import '../features/sensor/domain/usecases/create_sensor_usecase.dart';
import '../features/sensor/presentation/bloc/sensor/sensor_bloc.dart';

void sensorInjection(GetIt sl) {
  sl.registerFactory(() => SensorBloc(createSensorUsecase: sl()));

  sl.registerLazySingleton(() => CreateSensorUsecase(sl()));

  sl.registerLazySingleton<SensorRepository>(
      () => SensorRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<SensorRemoteDataSource>(
      () => SensorRemoteDataSourceImpl(sl()));
}
