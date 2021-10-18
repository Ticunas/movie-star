// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';

part 'movie_info_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class MovieInfoModel extends MovieInfo {
  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String title;
  @override
  @JsonKey(name: 'release_date')
  @HiveField(2)
  final String releaseDate;
  @override
  @JsonKey(name: 'vote_average')
  @HiveField(3)
  final double voteAvarage;
  @override
  @JsonKey(name: 'poster_path')
  @HiveField(4)
  final String posterPath;
  @override
  @JsonKey(defaultValue: false)
  @HiveField(5)
  bool favorited;

  MovieInfoModel(
    this.id,
    this.title,
    this.releaseDate,
    this.voteAvarage,
    this.posterPath,
    this.favorited,
  ) : super(id, title, releaseDate, voteAvarage, posterPath, favorited);

  factory MovieInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MovieInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieInfoModelToJson(this);

  factory MovieInfoModel.fromEntity(MovieInfo movie) {
    return MovieInfoModel(movie.id, movie.title, movie.releaseDate,
        movie.voteAvarage, movie.posterPath, movie.favorited);
  }
}
