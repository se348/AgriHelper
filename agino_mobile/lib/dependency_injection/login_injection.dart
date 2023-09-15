import 'package:get_it/get_it.dart';

import '../features/auth/domain/usecases/login_user_usecase.dart';
import '../features/auth/presentation/bloc/login_bloc/login_bloc.dart';


void injectLogin(GetIt sl){
  sl.registerFactory(() => LoginBloc(
      sl()));

  sl.registerLazySingleton(() => LoginUserUsecase(userRepository: sl()));
 
  
}