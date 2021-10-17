// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:movie_star/features/popular_movies/data/models/movie_info_model.dart';
import 'package:movie_star/features/popular_movies/domain/entities/popular_movie_response.dart';

part 'popular_movies_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PopularMoviesResponseModel extends PopularMoviesResponse {
  @override
  @JsonKey(name: 'results')
  List<MovieInfoModel> movies;
  @override
  int page;
  @override
  @JsonKey(name: 'total_pages')
  int totalPages;
  @override
  @JsonKey(name: 'total_results')
  int totalResults;

  PopularMoviesResponseModel(
    this.movies,
    this.page,
    this.totalPages,
    this.totalResults,
  ) : super(movies, page, totalPages, totalResults);

  factory PopularMoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PopularMoviesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMoviesResponseModelToJson(this);
}
