import 'package:hive/hive.dart';
import 'package:movie_star/features/popular_movies/data/data_sources/contract/movies_favorited_local_data_source.dart';
import 'package:movie_star/features/popular_movies/data/models/movie_info_model.dart';

class MovieFavoritedLocalDataSourceImpl
    implements MoviesFavoritedLocalDataSource {
  final String movieFavoritedBoxName = 'movie_favorited_box';

  final HiveInterface hive;

  MovieFavoritedLocalDataSourceImpl({required this.hive}) {
    hive.registerAdapter(MovieInfoModelAdapter());
  }
  @override
  Future<bool> hasFavorited(String id) async {
    var box = await hive.openBox(movieFavoritedBoxName);
    if (await box.get(id) != null) {
      return true;
    }
    return false;
  }

  @override
  void saveMovie(MovieInfoModel movie) async {
    var box = await hive.openBox<MovieInfoModel>(movieFavoritedBoxName);
    box.put(movie.id, movie);
  }

  @override
  void removeMovie(MovieInfoModel movie) async {
    var box = await hive.openBox<MovieInfoModel>(movieFavoritedBoxName);
    box.delete(movie.id);
  }

  @override
  Future<List<MovieInfoModel>> getAllFavoritedMovies() async {
    var box = await hive.openBox<MovieInfoModel>(movieFavoritedBoxName);
    return box.values.toList();
  }
}
