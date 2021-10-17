import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/presentation/store_state.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';

part 'save_credential_store.g.dart';

class SaveCredentialStore extends _SaveCredentialStore
    with _$SaveCredentialStore {
  SaveCredentialStore({required SaveCredentialUseCase useCase})
      : super(useCase);
}

abstract class _SaveCredentialStore with Store {
  final SaveCredentialUseCase _useCase;

  @observable
  late ObservableFuture<Either<Failure, Credential>> _resultFuture;

  @observable
  Credential? credential;

  @observable
  Failure? failure;

  _SaveCredentialStore(this._useCase);

  @computed
  StoreState get state {
    if (credential == null) {
      return StoreState.initial;
    }
    if (_resultFuture.status == FutureStatus.rejected) {
      return StoreState.erro;
    }
    if (_resultFuture.status == FutureStatus.pending) {
      if (credential != null) {
        return StoreState.loadingMore;
      }
      return StoreState.loading;
    }
    if (_resultFuture.status == FutureStatus.fulfilled) {
      if (credential == null) {
        return StoreState.erro;
      }
      return StoreState.loaded;
    }
    return StoreState.initial;
  }

  @action
  Future saveCredential(String name, String email) async {
    failure = null;
    _resultFuture = ObservableFuture(_useCase(Params(name, email)));

    final result = await _resultFuture;

    result.fold((l) => failure = l, (r) => credential = r);
  }
}
