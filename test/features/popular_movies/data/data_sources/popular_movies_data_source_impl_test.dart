import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/popular_movies_data_source_impl.dart';
import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart';

import '../../../../fixture_reader.dart';
import 'popular_movies_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late PopularMoviesDataSource dataSource;
  late Params tParams;
  late bool tForceRefresh;

  setUp(() {
    mockDio = MockDio();
    dataSource = PopularMoviesDataSourceImpl(dio: mockDio);
    tParams = Params(0);
    tForceRefresh = false;
  });

  Response getResponse200() {
    return Response(
        requestOptions: RequestOptions(path: 'test'),
        data: jsonDecode(fixture(
            'features/popular_movies/fixtures/popular_movies_200.json')),
        statusCode: 200);
  }

  group('Success', () {
    test(
      'Should return [PopularMoviesResponseModel] when request is successful ',
      () async {
        //arange
        when(mockDio.get(any, options: anyNamed('options')))
            .thenAnswer((_) async => getResponse200());
        //act
        final result =
            await dataSource.getPopularMoviesInfo(tParams, tForceRefresh);
        //assert
        expect(result, isA<PopularMoviesResponseModel>());
      },
    );
  });
}
