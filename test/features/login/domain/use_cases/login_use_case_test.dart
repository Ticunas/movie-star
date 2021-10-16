import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late SaveCredentialUseCase useCase;
  late MockLoginRepository mockRepository;
  late Credential tCredential;
  late Params tParams;
  late String tName;
  late String tEmail;

  setUp(() {
    mockRepository = MockLoginRepository();
    useCase = SaveCredentialUseCase(repository: mockRepository);
    tName = 'Test Name';
    tEmail = 'Test Email';
    tCredential = Credential(tName, tEmail);
    tParams = Params(tName, tEmail);
  });
  group('Success', () {
    test(
      'Should return credential when login is successful',
      () async {
        //arange
        when(mockRepository.login(tParams))
            .thenAnswer((_) async => Right(tCredential));
        //act
        final result = await useCase(tParams);
        //assert
        expect(result, Right(tCredential));
      },
    );
  });
  group('Fails', () {});
}
