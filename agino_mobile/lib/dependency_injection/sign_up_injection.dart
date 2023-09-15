import 'package:get_it/get_it.dart';

import '../features/auth/data/data_source/local/local_user_data_source.dart';
import '../features/auth/data/data_source/local/local_user_data_source_impl.dart';
import '../features/auth/data/data_source/remote/remote_user_data_source.dart';
import '../features/auth/data/data_source/remote/remote_user_data_source_impl.dart';
import '../features/auth/data/repositories/user_repository_impl.dart';
import '../features/auth/domain/repositories/user_repository.dart';
import '../features/auth/domain/usecases/cache_user_usecase.dart';
import '../features/auth/domain/usecases/get_cached_user_usecase.dart';
import '../features/auth/domain/usecases/signup_usecase.dart';
import '../features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';

void injectSignUp(GetIt sl){
  sl.registerFactory(() => SignUpBloc(
      cacheUserUsecase: sl(), getCachedUserUsecase: sl(), signUpUsecase: sl()));

  sl.registerLazySingleton(() => CacheUserUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => GetCachedUserUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(userRepository: sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      localUserDataSource: sl(),
      remoteUserDataSource: sl(),
      networkInfo: sl()));

  sl.registerLazySingleton<LocalUserDataSource>(
      () => LocalUserDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RemoteUserDataSource>(
      () => RemoteUserDataSourceImpl(dio: sl()));

}