import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/errors/failures/core_failures.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/movies_favorited_local_data_source.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';
import 'package:movie_star/features/popular_movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart';

import '../../../../fixture_reader.dart';
import 'popular_movies_repository_impl_test.mocks.dart';

@GenerateMocks([PopularMoviesDataSource, MoviesFavoritedLocalDataSource])
void main() {
  late MockPopularMoviesDataSource mockPopularMoviesDataSource;
  late MockMoviesFavoritedLocalDataSource mockMoviesFavoritedLocalDataSource;
  late PopularMoviesRepository repository;
  late Params tParams;
  late bool tForceRefresh;
  late PopularMoviesResponseModel tResponse;

  PopularMoviesResponseModel getPopularMovieResponseFromFixture() {
    return PopularMoviesResponseModel.fromJson(jsonDecode(
        fixture('features/popular_movies/fixtures/popular_movies_200.json')));
  }

  setUp(() {
    mockPopularMoviesDataSource = MockPopularMoviesDataSource();
    mockMoviesFavoritedLocalDataSource = MockMoviesFavoritedLocalDataSource();
    repository = PopularMoviesRepositoryImpl(
        dataSource: mockPopularMoviesDataSource,
        localDataSource: mockMoviesFavoritedLocalDataSource);
    tForceRefresh = false;
    tResponse = getPopularMovieResponseFromFixture();
    tParams = Params(0);
  });
  group('Success', () {
    test(
      'Should return [PopularMoviesResponse]  when request is successful ',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tParams, tForceRefresh))
            .thenAnswer((_) async => tResponse);
        //act
        final result =
            await repository.getPopularMovies(tParams, tForceRefresh);
        //assert
        expect(result, Right(tResponse));
      },
    );
  });
  group('Fails', () {
    test(
      'Should return [ConnectTimeOutFailure] when request not connect in time',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tParams, tForceRefresh))
            .thenThrow(ConnectTimeOutException());
        //act
        final response =
            await repository.getPopularMovies(tParams, tForceRefresh);
        //assert
        expect(response, Left(ConnectTimeoutFailure()));
      },
    );

    test(
      'Should return [ResponseTimeOutFailure] when response not returned in time',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tParams, tForceRefresh))
            .thenThrow(ResponseTimeOutException());
        //act
        final response =
            await repository.getPopularMovies(tParams, tForceRefresh);
        //assert
        expect(response, Left(ResponseTimeOutFailure()));
      },
    );

    test(
      'Should return [UnauthorizedFailure] when api have no authorization to data',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tParams, tForceRefresh))
            .thenThrow(UnauthorizedException());
        //act
        final response =
            await repository.getPopularMovies(tParams, tForceRefresh);
        //assert
        expect(response, Left(UnauthorizedFailure()));
      },
    );

    test(
      'Should return [NotFoundFailure] when data requested not found',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tParams, tForceRefresh))
            .thenThrow(NotFoundException());
        //act
        final response =
            await repository.getPopularMovies(tParams, tForceRefresh);
        //assert
        expect(response, Left(NotFoundFailure()));
      },
    );
  });
}
