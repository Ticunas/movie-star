import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/presentation/stores/check_credential_store.dart';

///Used to manage user Session
class Guard extends StatefulWidget {
  final CheckCredentialStore checkCredentialStore;
  const Guard({Key? key, required this.checkCredentialStore}) : super(key: key);

  @override
  _GuardState createState() => _GuardState();
}

class _GuardState extends State<Guard> {
  List<ReactionDisposer>? _disposers;

  @override
  void didChangeDependencies() {
    _disposers = [
      reaction(
          (_) => widget.checkCredentialStore.credential,
          (Credential? credential) => {
                if (credential == null)
                  {
                    //TODO call Login;
                  }
                else
                  {
                    //TODO call home
                  }
              }),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
