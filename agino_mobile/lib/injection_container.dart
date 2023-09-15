import 'dart:io';

import 'core/network/network_info.dart';
import 'dependency_injection/farm_detail_injection.dart';
import 'dependency_injection/farm_injection.dart';
import 'dependency_injection/field_injection.dart';
import 'dependency_injection/location_injection.dart';
import 'dependency_injection/login_injection.dart';
import 'dependency_injection/position_injection.dart';
import 'dependency_injection/sensor_injection.dart';
import 'dependency_injection/sign_up_injection.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'features/auth/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  injectSignUp(sl);
  locationInjection(sl);
  farmInjection(sl);
  fieldInjection(sl);
  farmDetailInjection(sl);
  positionInjector(sl);
  sensorInjection(sl);
  injectLogin(sl);
  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => ProfileBloc(sl(), sl()));

  sl.registerLazySingleton(() => LogoutUsecase(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  var dio = Dio();
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
