import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/di/injection.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/errors/failures/login_failures.dart';
import 'package:movie_star/core/session/credential_guard.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/presentation/stores/check_credential_store.dart';
import 'package:movie_star/features/login/presentation/stores/save_credential_store.dart';
import 'package:movie_star/routes/app_router.gr.dart';

///Used to manage user Session
class GuardPage extends StatefulWidget {
  final CheckCredentialStore checkCredentialStore;
  final CredentialGuard credentialGuard;
  const GuardPage(
      {Key? key,
      required this.checkCredentialStore,
      required this.credentialGuard})
      : super(key: key);

  @override
  _GuardPageState createState() => _GuardPageState();
}

class _GuardPageState extends State<GuardPage> {
  late StackRouter _router;
  late List<ReactionDisposer>? _disposers;

  @override
  void didChangeDependencies() {
    _disposers = [
      reaction(
          (_) => widget.checkCredentialStore.failure,
          (Failure? failure) => {
                if (failure == NoCredentialFailure())
                  {
                    _router.navigate(LoginRoute(
                        saveCredentialStore: sl<SaveCredentialStore>()))
                  }
              }),
      reaction((_) => widget.checkCredentialStore.credential,
          (Credential? credential) {
        if (credential != null) {
          widget.credentialGuard.setCredential(credential);
          _router.navigate(PopularMoviesRoute(
              credential: sl<CredentialGuard>().getCredential!));
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

  @override
  Widget build(BuildContext context) {
    _router = AutoRouter.of(context);
    widget.checkCredentialStore.checkIfHasCredential();
    return Container();
  }
}
