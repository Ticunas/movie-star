import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/data/models/credential_model.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';

abstract class LoginDataSource {
  ///Return [CredentialModel] when save successful
  ///
  ///Throw [HiveSaveException] when error occours trying to save data
  Future<CredentialModel> saveCredential(Params params);

  Future<CredentialModel> checkIfHasCredential(NoParams params);
}
