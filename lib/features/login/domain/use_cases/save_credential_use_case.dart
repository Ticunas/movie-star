import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';

class SaveCredentialUseCase extends UseCaseSingleRequest<Credential, Params> {
  final LoginRepository repository;

  SaveCredentialUseCase({required this.repository});
  @override
  Future<Either<Failure, Credential>> call(Params params) {
    return repository.login(params);
  }
}

class Params {
  final String name;
  final String email;

  Params(this.name, this.email);
}
