import 'package:movie_star/features/popular_movies/data/models/movie_info_model.dart';

abstract class MoviesFavoritedLocalDataSource {
  Future<bool> hasFavorited(String id);
  void saveMovie(MovieInfoModel movie);
  void removeMovie(MovieInfoModel movie);
  Future<List<MovieInfoModel>> getAllFavoritedMovies();
}
