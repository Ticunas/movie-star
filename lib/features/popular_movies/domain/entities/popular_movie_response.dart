import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';

class PopularMoviesResponse {
  final List<MovieInfo> movies;
  final int page;
  final int totalPages;
  final int totalResults;

  PopularMoviesResponse(
      this.movies, this.page, this.totalPages, this.totalResults);
}
