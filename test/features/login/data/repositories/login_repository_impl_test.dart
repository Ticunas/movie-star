import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/core/errors/exceptions.dart';
import 'package:movie_star/core/errors/failures/hive_failures.dart';
import 'package:movie_star/core/errors/failures/login_failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/data/data_sources/contract/login_data_source.dart';
import 'package:movie_star/features/login/data/models/credential_model.dart';
import 'package:movie_star/features/login/data/repositories/login_repository_impl.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginDataSource])
void main() {
  late MockLoginDataSource mockLoginDataSource;
  late LoginRepository repository;
  late CredentialModel tCredential;
  late Params tParams;
  late NoParams tNoParams;
  late String tName;
  late String tEmail;
  setUp(() {
    mockLoginDataSource = MockLoginDataSource();
    repository = LoginRepositoryImpl(dataSource: mockLoginDataSource);
    tName = 'Test Name';
    tEmail = 'Test Email';
    tCredential = CredentialModel(name: tName, email: tEmail);
    tParams = Params(tName, tEmail);
    tNoParams = NoParams();
  });

  group('Success', () {
    test(
      'Should return [Credential] when login is successful ',
      () async {
        //arange
        when(mockLoginDataSource.saveCredential(tParams))
            .thenAnswer((_) async => tCredential);
        //act
        final result = await repository.login(tParams);
        //assert
        expect(result, Right(tCredential));
      },
    );

    test(
      'Should return previous [Credential] if has credential',
      () async {
        //arange
        when(mockLoginDataSource.checkIfHasCredential(tNoParams))
            .thenAnswer((_) async => tCredential);
        //act
        final result = await repository.checkIfHasCredentials(tNoParams);
        //assert
        expect(result, Right(tCredential));
      },
    );
  });
  group('Fails', () {
    test(
      'Should return a [HiveSaveFailure] when some error occors trying to save credential',
      () async {
        //arange
        when(mockLoginDataSource.saveCredential(tParams))
            .thenThrow(HiveSaveException());
        //act
        final result = await repository.login(tParams);
        //assert
        expect(result, Left(HiveSaveFailure()));
      },
    );
  });

  test(
    'Should return [NoCredentialFailure] when user has no credential registered on app',
    () async {
      //arange
      when(mockLoginDataSource.checkIfHasCredential(tNoParams))
          .thenThrow(NoCredentialException());
      //act
      final result = await repository.checkIfHasCredentials(tNoParams);
      //assert
      expect(result, left(NoCredentialFailure()));
    },
  );
}
