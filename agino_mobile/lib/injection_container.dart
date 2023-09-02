import 'package:agino_mobile/features/auth/data/data_source/local/local_user_data_source.dart';
import 'package:agino_mobile/features/auth/data/data_source/local/local_user_data_source_impl.dart';
import 'package:agino_mobile/features/auth/data/repositories/user_repository_impl.dart';
import 'package:agino_mobile/features/auth/domain/repositories/user_repository.dart';
import 'package:agino_mobile/features/auth/domain/usecases/cache_user_usecase.dart';
import 'package:agino_mobile/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:agino_mobile/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => SignUpBloc(cacheUserUsecase: sl(), getCachedUserUsecase: sl()));

  sl.registerLazySingleton(() => CacheUserUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => GetCachedUserUsecase(userRepository: sl()));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(localUserDataSource: sl()));

  sl.registerLazySingleton<LocalUserDataSource>(
      () => LocalUserDataSourceImpl(sharedPreferences: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
