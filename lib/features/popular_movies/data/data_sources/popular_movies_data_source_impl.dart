import 'package:dio/dio.dart';
import 'package:movie_star/core/constants/dio_paths.dart' as paths;
import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/popular_movies_data_source.dart';
import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart';

class PopularMoviesDataSourceImpl implements PopularMoviesDataSource {
  final Dio dio;

  PopularMoviesDataSourceImpl({required this.dio});
  @override
  Future<PopularMoviesResponseModel> getPopularMoviesInfo(
      Params params, bool forceRefresh) async {
    try {
      final response = await dio.get(paths.movieDbPopularMovies,
          queryParameters: params.queryParams());
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
