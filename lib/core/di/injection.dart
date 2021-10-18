import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_star/core/dio/api_key.dart' as keys;
import 'package:movie_star/core/dio/custom_dio.dart';
import 'package:movie_star/core/session/credential_guard.dart';
import 'package:movie_star/features/login/di/injection.dart';
import 'package:movie_star/features/popular_movies/di/injection.dart';

final sl = GetIt.instance;

void init() {
  _core();
  initLoginDI();
  initPopularMoviesDI();
}

void _core() {
  //DB
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  //Dio
  sl.registerLazySingleton<CustomDio>(() => CustomDio(apiKey: keys.apiKey));

  sl.registerLazySingleton<CredentialGuard>(() => CredentialGuard());
}

void initRoute(BuildContext context) {
  sl.registerLazySingleton<StackRouter>(() => AutoRouter.of(context));
}
