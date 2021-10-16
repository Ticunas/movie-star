import 'package:movie_star/core/errors/expections.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/errors/failures/hive_failures.dart';
import 'package:movie_star/core/errors/failures/login_failures.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/login/data/data_sources/contract/login_data_source.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Credential>> login(Params params) async {
    try {
      return Right(await dataSource.saveCredential(params));
    } on HiveSaveException {
      return Left(HiveSaveFailure());
    }
  }

  @override
  Future<Either<Failure, Credential>> checkIfHasCredentials(
      NoParams params) async {
    try {
      final result = await dataSource.checkIfHasCredential(params);
      return Right(result);
    } on NoCredentialException {
      return Left(NoCredentialFailure());
    }
  }
}
