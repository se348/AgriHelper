import '../features/field/data/data_source/field_remote_data_source.dart';
import '../features/field/data/data_source/field_remote_data_source_impl.dart';
import '../features/field/data/repositories/field_repository_impl.dart';
import '../features/field/domain/repositories/field_repository.dart';
import '../features/field/domain/usecases/create_field_usecase.dart';
import '../features/field/domain/usecases/get_field_usecase.dart';
import '../features/field/presentation/bloc/field_bloc.dart';
import 'package:get_it/get_it.dart';

void fieldInjection(GetIt sl) {
  sl.registerFactory(() => FieldBloc(createFieldUsecase: sl(), getFieldUsecase: sl()));

  sl.registerLazySingleton(() => CreateFieldUsecase(sl()));
  sl.registerLazySingleton(() => GetFieldUsecase(sl()));

  sl.registerLazySingleton<FieldRepository>(() =>
      FieldRepositoryImpl(fieldRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FieldRemoteDataSource>(
      () => FieldRemoteDataSourceImpl(sl()));
}
