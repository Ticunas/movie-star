import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/errors/failures/core_failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';
import 'package:movie_star/features/popular_movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

import '../../../../fixture_reader.dart';
import 'popular_movies_repository_impl_test.mocks.dart';

@GenerateMocks([PopularMoviesDataSource])
void main() {
  late MockPopularMoviesDataSource mockPopularMoviesDataSource;
  late PopularMoviesRepository repository;
  late NoParams tNoparams;
  late bool tForceRefresh;
  late PopularMoviesResponseModel tResponse;

  PopularMoviesResponseModel getPopularMovieResponseFromFixture() {
    return PopularMoviesResponseModel.fromJson(jsonDecode(
        fixture('features/popular_movies/fixtures/popular_movies_200.json')));
  }

  setUp(() {
    mockPopularMoviesDataSource = MockPopularMoviesDataSource();
    repository =
        PopularMoviesRepositoryImpl(dataSource: mockPopularMoviesDataSource);
    tForceRefresh = false;
    tResponse = getPopularMovieResponseFromFixture();
    tNoparams = NoParams();
  });
  group('Success', () {
    test(
      'Should return [PopularMoviesResponse]  when request is successful ',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tNoparams, tForceRefresh))
            .thenAnswer((_) async => tResponse);
        //act
        final result =
            await repository.getPopularMovies(tNoparams, tForceRefresh);
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
                tNoparams, tForceRefresh))
            .thenThrow(ConnectTimeOutException());
        //act
        final response =
            await repository.getPopularMovies(tNoparams, tForceRefresh);
        //assert
        expect(response, Left(ConnectTimeoutFailure()));
      },
    );

    test(
      'Should return [ResponseTimeOutFailure] when response not returned in time',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tNoparams, tForceRefresh))
            .thenThrow(ResponseTimeOutException());
        //act
        final response =
            await repository.getPopularMovies(tNoparams, tForceRefresh);
        //assert
        expect(response, Left(ResponseTimeOutFailure()));
      },
    );

    test(
      'Should return [UnauthorizedFailure] when api have no authorization to data',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tNoparams, tForceRefresh))
            .thenThrow(UnauthorizedException());
        //act
        final response =
            await repository.getPopularMovies(tNoparams, tForceRefresh);
        //assert
        expect(response, Left(UnauthorizedFailure()));
      },
    );

    test(
      'Should return [NotFoundFailure] when data requested not found',
      () async {
        //arange
        when(mockPopularMoviesDataSource.getPopularMoviesInfo(
                tNoparams, tForceRefresh))
            .thenThrow(NotFoundException());
        //act
        final response =
            await repository.getPopularMovies(tNoparams, tForceRefresh);
        //assert
        expect(response, Left(NotFoundFailure()));
      },
    );
  });
}
