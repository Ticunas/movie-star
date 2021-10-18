import 'package:json_annotation/json_annotation.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_star/core/use_cases/use_case.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';
import 'package:movie_star/features/popular_movies/domain/repositories/popular_movies_repository.dart';

part 'get_popular_movies_info_use_case.g.dart';

class GetPopularMoviesInfoUseCase
    implements UseCaseMultipleRequest<PopularMoviesResponse, Params> {
  final PopularMoviesRepository repository;

  GetPopularMoviesInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, PopularMoviesResponse>> call(
      Params params, bool forceRefresh) {
    return repository.getPopularMovies(params, forceRefresh);
  }
}

@JsonSerializable()
class Params {
  final int page;
  Params(this.page);
  Map<String, dynamic> queryParams() => _$ParamsToJson(this);
}
