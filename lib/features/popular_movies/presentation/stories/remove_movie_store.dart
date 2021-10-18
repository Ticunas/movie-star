import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/presentation/store_state.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/remove_movie_use_case.dart';

part 'remove_movie_store.g.dart';

class RemoveMovieStore extends _RemoveMovieStore with _$RemoveMovieStore {
  RemoveMovieStore({required RemoveMovieUseCase useCase}) : super(useCase);
}

abstract class _RemoveMovieStore with Store {
  final RemoveMovieUseCase _useCase;
  @observable
  ObservableFuture<Either<Failure, NoReturn>>? _resultFuture;

  @observable
  NoReturn? result;

  @observable
  Failure? failure;

  _RemoveMovieStore(this._useCase);

  @computed
  StoreState get state {
    if (result == null) {
      return StoreState.initial;
    }
    if (_resultFuture?.status == FutureStatus.rejected) {
      return StoreState.erro;
    }
    if (_resultFuture?.status == FutureStatus.pending) {
      if (result != null) {
        return StoreState.loadingMore;
      }
      return StoreState.loading;
    }
    if (_resultFuture?.status == FutureStatus.fulfilled) {
      if (result == null) {
        return StoreState.erro;
      }
      return StoreState.loaded;
    }
    return StoreState.initial;
  }

  @action
  Future removeMovie(MovieInfo movie) async {
    failure = null;
    _resultFuture = ObservableFuture(_useCase(Params(movie)));

    final result = await _resultFuture;

    result?.fold((l) => failure = l, (r) => this.result = r);
  }
}
