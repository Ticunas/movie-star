import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_star/core/errors/failures/login_failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';
import 'package:movie_star/features/login/domain/use_cases/check_if_has_credentrial_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late MockLoginRepository mockLoginRepository;
  late CheckIfHasCredentialUseCase useCase;
  late Credential tCredential;
  late String tName;
  late String tEmail;
  late NoParams tNoParams;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    useCase = CheckIfHasCredentialUseCase(repository: mockLoginRepository);
    tName = 'Test Name';
    tEmail = 'Test Email';
    tCredential = Credential(tName, tEmail);
    tNoParams = NoParams();
  });
  group('Success', () {
    test(
      'Should return previous [Credential] if has credential',
      () async {
        //arange
        when(mockLoginRepository.checkIfHasCredentials(tNoParams))
            .thenAnswer((_) async => Right(tCredential));
        //act
        final result = await useCase(tNoParams);
        //assert
        expect(result, Right(tCredential));
      },
    );
  });
  group('Fails', () {
    test(
      'Should return [NoCredentialFailure] when user has no credential registered on app',
      () async {
        //arange
        when(mockLoginRepository.checkIfHasCredentials(tNoParams))
            .thenAnswer((realInvocation) async => Left(NoCredentialFailure()));
        //act
        final result =
            await useCase.repository.checkIfHasCredentials(tNoParams);
        //assert
        expect(result, Left(NoCredentialFailure()));
      },
    );
  });
}
