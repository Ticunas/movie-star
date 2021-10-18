import 'package:dartz/dartz.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

class RemoveMovieUseCase implements UseCaseSingleRequest<NoReturn, Params> {
  final PopularMoviesRepository repository;

  RemoveMovieUseCase({required this.repository});

  @override
  Future<Either<Failure, NoReturn>> call(Params params) {
    return repository.removeMovie(params);
  }
}

class Params {
  final MovieInfo movie;

  Params(this.movie);
}
