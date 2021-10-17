import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

class GetPopularMoviesInfo
    implements UseCaseMultipleRequest<PopularMoviesResponse, NoParams> {
  final PopularMoviesRepository repository;

  GetPopularMoviesInfo({required this.repository});

  @override
  Future<Either<Failure, PopularMoviesResponse>> call(
      NoParams params, bool forceRefresh) {
    return repository.getPopularMovies(params, forceRefresh);
  }
}
