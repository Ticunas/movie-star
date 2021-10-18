import 'package:movie_star/features/popular_movies/data/models/popular_movies_response_model.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart';

abstract class PopularMoviesDataSource {
  ///Return [PopularMovieResponse]
  ///
  ///Throw [ConnectTimeOutException] when could not connect to server in time
  ///
  ///Throw [ResponseTimeOutException] when could not receive response in time
  ///
  ///Throw [UnauthorizedException] when api has no authorization
  ///
  ///Throw [NotFoundException] when data could not be found
  ///
  ///Throw [UnkowException] when some unknow error occours
  Future<PopularMoviesResponseModel> getPopularMoviesInfo(
      Params params, bool forceRefresh);
}
