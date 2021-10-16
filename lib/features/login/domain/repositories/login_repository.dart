import 'package:dartz/dartz.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';

abstract class LoginRepository {
  Future<Either<Failure, Credential>> login(Params params);
  Future<Either<Failure, Credential>> checkIfHasCredentials(NoParams params);
}
