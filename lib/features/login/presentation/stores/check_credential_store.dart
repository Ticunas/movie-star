import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/presentation/store_state.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/domain/use_cases/check_if_has_credentrial_use_case.dart';

part 'check_credential_store.g.dart';

class CheckCredentialStore extends _CheckCredentialStore
    with _$CheckCredentialStore {
  CheckCredentialStore({required CheckIfHasCredentialUseCase useCase})
      : super(useCase);
}

abstract class _CheckCredentialStore with Store {
  final CheckIfHasCredentialUseCase _useCase;

  @observable
  ObservableFuture<Either<Failure, Credential>>? _resultFuture;

  @observable
  Credential? credential;

  @observable
  Failure? failure;

  _CheckCredentialStore(this._useCase);

  @computed
  StoreState get state {
    if (credential == null) {
      return StoreState.initial;
    }
    if (_resultFuture?.status == FutureStatus.rejected) {
      return StoreState.erro;
    }
    if (_resultFuture?.status == FutureStatus.pending) {
      if (credential != null) {
        return StoreState.loadingMore;
      }
      return StoreState.loading;
    }
    if (_resultFuture?.status == FutureStatus.fulfilled) {
      if (credential == null) {
        return StoreState.erro;
      }
      return StoreState.loaded;
    }
    return StoreState.initial;
  }

  @action
  Future checkIfHasCredential() async {
    failure = null;
    _resultFuture = ObservableFuture(_useCase(NoParams()));

    final result = await _resultFuture;

    result?.fold((l) => failure = l, (r) => credential = r);
  }
}
