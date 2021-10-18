import 'package:dartz/dartz.dart';
import 'package:movie_star/core/errors/failures.dart';

abstract class UseCaseMultipleRequest<Type, Params> {
  Future<Either<Failure, Type>> call(Params params, bool forceRefresh);
}

abstract class UseCaseSingleRequest<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

///Used for all UseCase that no need Params
class NoParams {}

class NoReturn {}
