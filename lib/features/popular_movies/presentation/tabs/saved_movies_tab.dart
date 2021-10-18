import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/di/injection.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/presentation/widgets/snack_bar_factory.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/get_movies_local_saved_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/remove_movie_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/save_movie_store.dart';
import 'package:movie_star/features/popular_movies/presentation/widgets/movie_tile.dart';

class SavedMoviesTab extends StatefulWidget {
  final GetMoviesLocalSavedStore store;
  SavedMoviesTab({Key? key, required this.store}) : super(key: key);

  @override
  _SavedMoviesTabState createState() => _SavedMoviesTabState();
}

class _SavedMoviesTabState extends State<SavedMoviesTab> {
  late ScaffoldMessengerState _scaffoldMessenger;
  List<ReactionDisposer>? _disposers;
  late StackRouter _router;

  @override
  Widget build(BuildContext context) {
    _router = AutoRouter.of(context);
    _scaffoldMessenger = ScaffoldMessenger.of(context);
    return Observer(builder: (_) {
      return ListView.builder(
          controller: ScrollController(),
          itemCount: widget.store.result.length,
          itemBuilder: (_, i) => MovieTile(
                movie: widget.store.result[i],
                removeMovieStore: sl<RemoveMovieStore>(),
                saveMovieStore: sl<SaveMovieStore>(),
                callback: (MovieInfo movie) {
                  widget.store.result.remove(movie);
                },
              ));
    });
  }

  @override
  void initState() {
    widget.store.getAllSavedMovies();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _disposers = [
      reaction(
          (_) => widget.store.failure,
          (Failure? failure) => {
                if (failure != null)
                  {
                    _scaffoldMessenger.showSnackBar(buildSnackBarError(
                        '${failure.getMessage()}, code: ${failure.getCode()}',
                        _scaffoldMessenger))
                  }
              })
    ];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _disposers?.forEach((element) {
      element();
    });
    super.dispose();
  }
}
