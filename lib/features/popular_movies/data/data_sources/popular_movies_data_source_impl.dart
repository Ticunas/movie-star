import 'package:dio/dio.dart';
import 'package:movie_star/core/constants/dio_paths.dart' as paths;
import 'package:movie_star/core/data/data_sources/dio_data_source.dart';
import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';

class PopularMoviesDataSourceImpl
    with DioDataSourceCache
    implements PopularMoviesDataSource {
  final Dio dio;
  final Duration cacheTime = const Duration(days: 2);
  final Duration maxStaleTime = const Duration(days: 1);

  PopularMoviesDataSourceImpl({required this.dio});
  @override
  Future<PopularMoviesResponseModel> getPopularMoviesInfo(
      NoParams params, bool forceRefresh) async {
    try {
      final response = await dio.get(paths.moviedb_popular_movies,
          options: customRequestOptions(forceRefresh, cacheTime, maxStaleTime));
      return PopularMoviesResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.error != null && e.type == DioErrorType.other) {
        throw e.error;
      } else {
        throw UnknowException();
      }
    }
  }
}
