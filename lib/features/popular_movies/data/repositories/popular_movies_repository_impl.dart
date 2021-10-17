import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/errors/failures/core_failures.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

class PopularMoviesRepositoryImpl implements PopularMoviesRepository {
  final PopularMoviesDataSource dataSource;

  PopularMoviesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PopularMoviesResponse>> getPopularMovies(
      NoParams params, bool forceRefresh) async {
    try {
      return Right(await dataSource.getPopularMoviesInfo(params, forceRefresh));
    } on ConnectTimeOutException {
      return Left(ConnectTimeoutFailure());
    } on ResponseTimeOutException {
      return Left(ResponseTimeOutFailure());
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    }
  }
}
