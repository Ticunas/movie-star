import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/presentation/store_state.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/domain/use_cases/get_movies_local_saved_user_case.dart';

part 'get_movies_local_saved_store.g.dart';

class GetMoviesLocalSavedStore extends _GetMoviesLocalSavedStore
    with _$GetMoviesLocalSavedStore {
  GetMoviesLocalSavedStore({required GetMoviesLocalSavedUseCase useCase})
      : super(useCase);
}

abstract class _GetMoviesLocalSavedStore with Store {
  final GetMoviesLocalSavedUseCase _useCase;
  _GetMoviesLocalSavedStore(this._useCase);
  @observable
  ObservableFuture<Either<Failure, List<MovieInfo>>>? _resultFuture;

  @observable
  List<MovieInfo> result = [];
  @observable
  Failure? failure;

  @computed
  StoreState get state {
    if (result.isEmpty) {
      return StoreState.initial;
    }
    if (_resultFuture?.status == FutureStatus.rejected) {
      return StoreState.erro;
    }
    if (_resultFuture?.status == FutureStatus.pending) {
      return StoreState.loading;
    }
    if (_resultFuture?.status == FutureStatus.fulfilled) {
      if (result.isEmpty) {
        return StoreState.erro;
      }
      return StoreState.loaded;
    }
    return StoreState.initial;
  }

  @action
  Future getAllSavedMovies() async {
    failure = null;
    _resultFuture = ObservableFuture(_useCase(NoParams()));

    final result = await _resultFuture;

    result?.fold((l) => failure = l, (r) => this.result.addAll(r));
  }
}
