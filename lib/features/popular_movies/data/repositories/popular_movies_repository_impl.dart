import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/errors/failures/core_failures.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/movies_favorited_local_data_source.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/models/movie_info_model.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart'
    as get_popular_movies;
import 'package:movie_star/features/popular_movies/domain/use_cases/save_movie_use_case.dart'
    as save_usecase;
import 'package:movie_star/features/popular_movies/domain/use_cases/remove_movie_use_case.dart'
    as remove_usecase;

class PopularMoviesRepositoryImpl implements PopularMoviesRepository {
  final PopularMoviesDataSource dataSource;
  final MoviesFavoritedLocalDataSource localDataSource;

  PopularMoviesRepositoryImpl(
      {required this.dataSource, required this.localDataSource});

  @override
  Future<Either<Failure, PopularMoviesResponse>> getPopularMovies(
      get_popular_movies.Params params, bool forceRefresh) async {
    try {
      var result = await dataSource.getPopularMoviesInfo(params, forceRefresh);
      result.movies.map((e) async =>
          e.favorited = await localDataSource.hasFavorited(e.id.toString()));
      return Right(result);
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

  @override
  Future<Either<Failure, NoReturn>> removeMovie(
      remove_usecase.Params params) async {
    try {
      MovieInfoModel movieModel = MovieInfoModel.fromEntity(params.movie);
      localDataSource.removeMovie(movieModel);
      return Right(NoReturn());
    } catch (e) {
      return Left(UnknowFailure());
    }
  }

  @override
  Future<Either<Failure, NoReturn>> saveMovie(
      save_usecase.Params params) async {
    try {
      MovieInfoModel movieModel = MovieInfoModel.fromEntity(params.movie);
      localDataSource.saveMovie(movieModel);
      return Right(NoReturn());
    } catch (e) {
      return Left(UnknowFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieInfo>>> getAllSavedMovies(
      NoParams params) async {
    try {
      return Right(await localDataSource.getAllFavoritedMovies());
    } catch (e) {
      return Left(UnknowFailure());
    }
  }
}
