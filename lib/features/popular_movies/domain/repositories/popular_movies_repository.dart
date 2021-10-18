import 'package:dartz/dartz.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart'
    as get_popular_movies;
import 'package:movie_star/features/popular_movies/domain/use_cases/save_movie_use_case.dart'
    as save_usecase;
import 'package:movie_star/features/popular_movies/domain/use_cases/remove_movie_use_case.dart'
    as remove_usecase;

abstract class PopularMoviesRepository {
  Future<Either<Failure, PopularMoviesResponse>> getPopularMovies(
      get_popular_movies.Params params, bool forceRefresh);

  Future<Either<Failure, NoReturn>> saveMovie(save_usecase.Params params);

  Future<Either<Failure, NoReturn>> removeMovie(remove_usecase.Params params);

  Future<Either<Failure, List<MovieInfo>>> getAllSavedMovies(NoParams params);
}
