import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

class GetMoviesLocalSavedUseCase
    extends UseCaseSingleRequest<List<MovieInfo>, NoParams> {
  final PopularMoviesRepository repository;

  GetMoviesLocalSavedUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieInfo>>> call(NoParams params) {
    return repository.getAllSavedMovies(params);
  }
}
