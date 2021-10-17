import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_star/core/dio/api_key.dart' as keys;
import 'package:movie_star/core/dio/custom_dio.dart';
import 'package:movie_star/features/login/di/injection.dart';

final sl = GetIt.instance;

void init() {
  _core();
  initLoginDI();
}

void _core() {
  //DB
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  //Dio
  sl.registerFactory<CustomDio>(() => CustomDio(apiKey: keys.apiKey));
}
