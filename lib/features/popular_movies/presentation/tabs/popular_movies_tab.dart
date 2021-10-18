import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_star/core/di/injection.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/get_movies_remote_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/remove_movie_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/save_movie_store.dart';
import 'package:movie_star/features/popular_movies/presentation/widgets/movie_tile.dart';

class PopularMoviesTab extends StatefulWidget {
  final GetMoviesRemoteStore getMoviesStore;

  PopularMoviesTab({
    Key? key,
    required this.getMoviesStore,
  }) : super(key: key);

  @override
  _PopularMoviesTabState createState() => _PopularMoviesTabState();
}

class _PopularMoviesTabState extends State<PopularMoviesTab> {
  @override
  void initState() {
    widget.getMoviesStore.paginationController
        .addPageRequestListener((pageKey) {
      widget.getMoviesStore.getMoviesByPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, MovieInfo>(
      pagingController: widget.getMoviesStore.paginationController,
      builderDelegate: PagedChildBuilderDelegate<MovieInfo>(
          itemBuilder: (context, item, index) => MovieTile(
                movie: item,
                removeMovieStore: sl<RemoveMovieStore>(),
                saveMovieStore: sl<SaveMovieStore>(),
              )),
    );
  }
}
