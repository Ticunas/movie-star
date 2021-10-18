import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_popular_movies_info_use_case.dart';

part 'get_movies_remote_store.g.dart';

class GetMoviesRemoteStore extends _GetMoviesStore with _$GetMoviesRemoteStore {
  GetMoviesRemoteStore({required GetPopularMoviesInfoUseCase useCase})
      : super(useCase);
}

abstract class _GetMoviesStore with Store {
  final GetPopularMoviesInfoUseCase _useCase;

  final PagingController<int, MovieInfo> _pagingController =
      PagingController(firstPageKey: 1);

  _GetMoviesStore(this._useCase);

  PagingController<int, MovieInfo> get paginationController =>
      _pagingController;

  @observable
  ObservableFuture<Either<Failure, PopularMoviesResponse>>? _resultFuture;

  int downloadElements = 0;

  @action
  Future getMoviesByPage(page) async {
    _resultFuture = ObservableFuture(_useCase(Params(page), false));

    final result = await _resultFuture;
    result?.fold((l) {
      _pagingController.error = l.getMessage();
    }, (r) {
      downloadElements += r.movies.length;
      if (r.totalResults == downloadElements) {
        _pagingController.appendLastPage(r.movies);
      } else {
        _pagingController.appendPage(r.movies, ++page);
      }
    });
  }
}
