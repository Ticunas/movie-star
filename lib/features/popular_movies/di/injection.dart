import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movie_star/core/dio/custom_dio.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/movies_favorited_local_data_source.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/movie_favorited_local_data_source_impl.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/popular_movies_data_source_impl.dart';
import 'package:movie_star/features/popular_movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_movies_local_saved_user_case.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/remove_movie_use_case.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/save_movie_use_case.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/get_movies_local_saved_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/get_movies_remote_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/remove_movie_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/save_movie_store.dart';

final sl = GetIt.instance;
void initPopularMoviesDI() {
  //DataSource
  sl.registerLazySingleton<PopularMoviesDataSource>(
      () => PopularMoviesDataSourceImpl(dio: sl<CustomDio>().getDio()));

  sl.registerLazySingleton<MoviesFavoritedLocalDataSource>(
      () => MoviesFavoritedLocalDataSourceImpl(hive: sl<HiveInterface>()));

  //Repository
  sl.registerLazySingleton<PopularMoviesRepository>(() =>
      PopularMoviesRepositoryImpl(
          dataSource: sl<PopularMoviesDataSource>(),
          localDataSource: sl<MoviesFavoritedLocalDataSource>()));

  //UseCase
  sl.registerLazySingleton<GetPopularMoviesInfoUseCase>(() =>
      GetPopularMoviesInfoUseCase(repository: sl<PopularMoviesRepository>()));
  sl.registerLazySingleton<RemoveMovieUseCase>(
      () => RemoveMovieUseCase(repository: sl<PopularMoviesRepository>()));
  sl.registerLazySingleton<SaveMovieUseCase>(
      () => SaveMovieUseCase(repository: sl<PopularMoviesRepository>()));
  sl.registerLazySingleton<GetMoviesLocalSavedUseCase>(() =>
      GetMoviesLocalSavedUseCase(repository: sl<PopularMoviesRepository>()));
  //Store
  sl.registerFactory<GetMoviesRemoteStore>(
      () => GetMoviesRemoteStore(useCase: sl<GetPopularMoviesInfoUseCase>()));
  sl.registerFactory<SaveMovieStore>(
      () => SaveMovieStore(useCase: sl<SaveMovieUseCase>()));
  sl.registerFactory<RemoveMovieStore>(
      () => RemoveMovieStore(useCase: sl<RemoveMovieUseCase>()));
  sl.registerFactory<GetMoviesLocalSavedStore>(() =>
      GetMoviesLocalSavedStore(useCase: sl<GetMoviesLocalSavedUseCase>()));
}
