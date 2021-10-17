import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/data/data_sources/contract/login_data_source.dart';
import 'package:movie_star/features/login/data/data_sources/login_data_source_impl.dart';
import 'package:movie_star/features/login/data/models/credential_model.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';

void main() {
  late HiveInterface hiveInterface;
  late Params tParams;
  late NoParams tNoParams;
  late String tName;
  late String tEmail;
  const String boxName = 'credential_box';
  late CredentialModel tCredentialModel;
  late LoginDataSource loginDataSource;

  void initHive() {
    hiveInterface = Hive;
    var path = Directory.current.path;
    hiveInterface.init(path + '/test/hive_testing_path');
  }

  setUpAll(() {
    initHive();
    loginDataSource = LoginDataSourceImpl(hive: hiveInterface);
  });

  setUp(() {
    tName = 'Test Name';
    tEmail = 'Test Email';
    tParams = Params(tName, tEmail);
    tNoParams = NoParams();
    tCredentialModel = CredentialModel(name: tName, email: tEmail);
  });

  tearDown(() {
    hiveInterface.deleteBoxFromDisk(boxName);
  });

  void putACredentialOnHive() async {
    var tbox = await hiveInterface.openBox(boxName);
    await tbox.add(tCredentialModel);
    await tbox.close();
  }

  group('Success', () {
    test(
      'Should save name and email and return [CredentialModel] when send params correctly',
      () async {
        //arange
        //act
        final result = await loginDataSource.saveCredential(tParams);
        //assert
        expect(result.name, tName);
        expect(result.email, tEmail);
      },
    );

    test(
      'Should return previous [Credential] if has credential',
      () async {
        //arange
        putACredentialOnHive();
        //act
        final result = await loginDataSource.checkIfHasCredential(tNoParams);
        //assert
        expect(result.name, tCredentialModel.name);
        expect(result.email, tCredentialModel.email);
      },
    );
  });

  group('Fail', () {
    test(
      'Should throw [NoCredentialException] when user has no previous credential registered',
      () async {
        //arange

        //act
        final call = loginDataSource.checkIfHasCredential;
        //assert
        expect(call(tNoParams), throwsA(isA<NoCredentialException>()));
      },
    );
  });
}
