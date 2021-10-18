import 'package:movie_star/features/login/domain/entities/credential.dart';

class CredentialGuard {
  Credential? _credential;

  Credential? get getCredential => _credential;

  void setCredential(Credential credential) => _credential = credential;
}
