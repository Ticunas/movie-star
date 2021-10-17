import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movie_star/features/login/data/data_sources/contract/login_data_source.dart';
import 'package:movie_star/features/login/data/data_sources/login_data_source_impl.dart';
import 'package:movie_star/features/login/data/repositories/login_repository_impl.dart';
import 'package:movie_star/features/login/domain/repositories/login_repository.dart';
import 'package:movie_star/features/login/domain/use_cases/check_if_has_credentrial_use_case.dart';
import 'package:movie_star/features/login/domain/use_cases/save_credential_use_case.dart';
import 'package:movie_star/features/login/presentation/stores/check_credential_store.dart';
import 'package:movie_star/features/login/presentation/stores/save_credential_store.dart';

final sl = GetIt.instance;
void initLoginDI() {
  //DataSource
  sl.registerLazySingleton<LoginDataSource>(
      () => LoginDataSourceImpl(hive: sl<HiveInterface>()));
  //Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(dataSource: sl<LoginDataSource>()));
  //UseCase
  sl.registerLazySingleton<CheckIfHasCredentialUseCase>(
      () => CheckIfHasCredentialUseCase(repository: sl<LoginRepository>()));

  sl.registerLazySingleton<SaveCredentialUseCase>(
      () => SaveCredentialUseCase(repository: sl<LoginRepository>()));

  //Store
  sl.registerFactory<CheckCredentialStore>(
      () => CheckCredentialStore(useCase: sl<CheckIfHasCredentialUseCase>()));

  sl.registerFactory<SaveCredentialStore>(
      () => SaveCredentialStore(useCase: sl<SaveCredentialUseCase>()));
}
