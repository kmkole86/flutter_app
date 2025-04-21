import 'package:data/src/model/movie_page_data.dart';
import 'package:data/src/model/movie_with_favourite_data.dart';
import 'package:domain/domain.dart';
import 'package:either_dart/either.dart';

abstract class MovieDatabaseDataSource {
  Future<void> cacheMovies({required PageData page});

  Future<void> clearMoviesCache();

  Future<List<MovieWithFavouriteData>> getMovies();

  Stream<List<MovieWithFavouriteData>> observeMovies();

  Stream<List<MovieWithFavouriteData>> observeFavouriteMovies();

  Future<Either<FavouriteStatusError, bool>> changeMovieFavouriteStatus({
    required int id,
  });

  Stream<bool> observeMovieFavouriteStatus({required int id});
}
