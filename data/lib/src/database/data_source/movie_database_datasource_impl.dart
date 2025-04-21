import 'package:data/src/data_source/movie_database_datasource.dart';
import 'package:data/src/database/flutter_app_database.dart';
import 'package:data/src/model/movie_page_data.dart';
import 'package:data/src/model/movie_with_favourite_data.dart';
import 'package:domain/domain.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';

final class MovieDatabaseDataSourceImpl extends MovieDatabaseDataSource {
  final FlutterAppDatabase _database;

  MovieDatabaseDataSourceImpl({required FlutterAppDatabase database})
    : _database = database;

  @override
  Future<void> cacheMovies({required PageData page}) =>
      _database.cacheMovies(pageOrdinal: page.ordinal, movies: page.movies);

  @override
  Future<Either<FavouriteStatusError, bool>> changeMovieFavouriteStatus({
    required int id,
  }) async {
    try {
      return Right(await _database.changeMovieFavouriteStatus(id: id));
    } catch (e) {
      return Left(FavouriteGenericError());
    }
  }

  @override
  Future<void> clearMoviesCache() => _database.clearMoviesCache();

  @override
  Stream<bool> observeMovieFavouriteStatus({required int id}) => _database
      .observeMovieFavouriteStatus(id: id)
      .distinct((prev, current) => prev != current); //distinct until changed

  @override
  Stream<List<MovieWithFavouriteData>> observeFavouriteMovies() => _database
      .observeMovieFavourites()
      .distinct((prev, current) => listEquals(prev, current));

  @override
  Stream<List<MovieWithFavouriteData>> observeMovies() => _database
      .observeMovies()
      .distinct((prev, current) => listEquals(prev, current));

  @override
  Future<List<MovieWithFavouriteData>> getMovies() => _database.getMovies();
}
