import 'package:dartz/dartz.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';

abstract class PopularMoviesRepository {
  Future<Either<Failure, PopularMoviesResponse>> getPopularMovies(
      NoParams params, bool forceRefresh);
}
