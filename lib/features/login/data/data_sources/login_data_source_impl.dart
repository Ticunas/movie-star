import 'package:hive/hive.dart';
import 'package:movie_star/core/errors/expections.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/data/data_sources/contract/login_data_source.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';
import 'package:movie_star/features/login/data/models/credential_model.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final String credentialBoxName = 'credential_box';

  final HiveInterface hive;

  LoginDataSourceImpl({required this.hive}) {
    hive.registerAdapter(CredentialModelAdapter());
  }
  @override
  Future<CredentialModel> saveCredential(Params params) async {
    final CredentialModel credential =
        CredentialModel(name: params.name, email: params.email);
    var box = await hive.openBox(credentialBoxName);
    int index = await box.add(credential);
    if (index > -1) {
      return credential;
    } else {
      throw HiveSaveException();
    }
  }

  @override
  Future<CredentialModel> checkIfHasCredential(NoParams params) async {
    var box = await hive.openBox(credentialBoxName);
    try {
      return box.getAt(0);
    } on IndexError {
      throw NoCredentialException();
    }
  }
}
