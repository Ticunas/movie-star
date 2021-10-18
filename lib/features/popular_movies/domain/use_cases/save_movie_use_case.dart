import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

class SaveMovieUseCase implements UseCaseSingleRequest<NoReturn, Params> {
  final PopularMoviesRepository repository;

  SaveMovieUseCase({required this.repository});
  @override
  Future<Either<Failure, NoReturn>> call(Params params) {
    return repository.saveMovie(params);
  }
}

class Params {
  final MovieInfo movie;

  Params(this.movie);
}
