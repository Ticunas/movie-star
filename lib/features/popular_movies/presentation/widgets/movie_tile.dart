import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/material.dart';
import 'package:movie_star/core/constants/dio_constants.dart';
import 'package:movie_star/core/utils/date_formate_utils.dart';
import 'package:movie_star/features/popular_movies/domain/entities/movie_info.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/remove_movie_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/save_movie_store.dart';

class MovieTile extends StatelessWidget {
  final MovieInfo movie;
  final SaveMovieStore saveMovieStore;
  final RemoveMovieStore removeMovieStore;
  Function(MovieInfo)? callback;

  MovieTile(
      {Key? key,
      required this.movie,
      required this.saveMovieStore,
      required this.removeMovieStore,
      callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          _porterAndRating(),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _name(movie.title),
              const SizedBox(
                height: 10,
              ),
              _releaseDate(movie.releaseDate),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                movie.favorited
                    ? removeMovieStore.removeMovie(movie)
                    : saveMovieStore.saveMovie(movie);
                if (callback != null) {
                  callback!(movie);
                }
                ;
              },
              child: movie.favorited
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    )
                  : const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.redAccent,
                    ),
            ),
          )
        ]));
  }

  Widget _porterAndRating() {
    return Stack(alignment: Alignment.bottomRight, children: [
      SizedBox(
        width: 100,
        height: 150,
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: CachedNetworkImageBuilder(
              url: basePosterUrl + movie.posterPath,
              builder: (image) {
                return Center(child: Image.file(image));
              },
              placeHolder: const LinearProgressIndicator(),
              errorWidget: const Icon(Icons.error)),
        ),
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: _getVoteColor(movie.voteAvarage),
              value: movie.voteAvarage / 10,
            ),
          ),
          Text(
            ((movie.voteAvarage * 10).toInt().toString() + '%'),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      )
    ]);
  }
}

_releaseDate(String releaseDate) {
  return Text(
    dateFormatyyyyMMddToddMMyyyy(releaseDate),
    maxLines: 2,
    style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
  );
}

Widget _name(String name) {
  return SizedBox(
    width: 200,
    child: Text(
      name,
      maxLines: 2,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Color _getVoteColor(double vote) {
  if (vote > 8) return Colors.green;
  if (vote > 6) return Colors.yellow;
  if (vote > 3) return Colors.orange;
  return Colors.red;
}
