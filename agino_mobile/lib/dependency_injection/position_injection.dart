import '../features/sensor/domain/repositories/position_repository.dart';
import '../features/sensor/domain/usecases/get_position_usecase.dart';
import 'package:get_it/get_it.dart';

import '../features/sensor/data/repositories/position_repository_impl.dart';
import '../features/sensor/presentation/bloc/position/position_bloc.dart';

void positionInjector(GetIt sl) {
  sl.registerFactory(() => PositionBloc(getPositionUsecase: sl()));

  sl.registerLazySingleton(() => GetPositionUsecase(sl()));

  sl.registerLazySingleton<PositionRepository>(
      () => PositionRepositoryImpl(networkInfo: sl()));
}
