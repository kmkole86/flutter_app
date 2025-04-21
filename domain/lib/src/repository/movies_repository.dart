import 'package:domain/src/entity/movie.dart';
import 'package:domain/src/entity/result/favourite_status_result.dart';
import 'package:domain/src/entity/result/movie_details_result.dart';
import 'package:domain/src/entity/result/movie_result.dart';

abstract class MoviesRepository {
  Stream<List<Movie>> observeMovies();

  Stream<MoviesResult> fetchMoviePage({
    required String searchText,
    required int cursor,
  });

  Stream<FavouriteStatusResult> changeMovieFavouriteStatus({required int id});

  Stream<List<Movie>> observeFavouriteMovies();

  Stream<MovieDetailsResult> fetchMovieDetails({required int id});

  Stream<bool> observeMovieFavouriteStatus({required int id});
}
