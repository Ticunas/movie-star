import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';

class CheckIfHasCredentialUseCase
    implements UseCaseSingleRequest<Credential, NoParams> {
  final LoginRepository repository;

  CheckIfHasCredentialUseCase({required this.repository});
  @override
  Future<Either<Failure, Credential>> call(NoParams params) async {
    return repository.checkIfHasCredentials(params);
  }
}
