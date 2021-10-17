import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info.dart';

import '../../../../fixture_reader.dart';
import 'get_popular_movies_info_test.mocks.dart';

@GenerateMocks([PopularMoviesRepository])
void main() {
  late MockPopularMoviesRepository mockPopularMoviesRepository;
  late GetPopularMoviesInfo usecase;
  late NoParams tNoParams;
  late bool tForcerefresh;
  late PopularMoviesResponse tResponse;

  PopularMoviesResponse getPopularMovieResponseFromFixture() {
    return PopularMoviesResponseModel.fromJson(jsonDecode(
        fixture('features/popular_movies/fixtures/popular_movies_200.json')));
  }

  setUp(() {
    mockPopularMoviesRepository = MockPopularMoviesRepository();
    usecase = GetPopularMoviesInfo(repository: mockPopularMoviesRepository);
    tNoParams = NoParams();
    tForcerefresh = false;
    tResponse = getPopularMovieResponseFromFixture();
  });

  group('Success', () {
    test(
      'Should return a [PopularMoviesRepsonse] when request is successful',
      () async {
        //arange
        when(mockPopularMoviesRepository.getPopularMovies(
                tNoParams, tForcerefresh))
            .thenAnswer((_) async => Right(tResponse));
        //act
        final response = await usecase(tNoParams, tForcerefresh);
        //assert
        expect(response, Right(tResponse));
      },
    );
  });
  group('Fails', () {});
}
