import 'package:data/src/common/mappers.dart';
import 'package:data/src/data_source/movie_api_datasource.dart';
import 'package:data/src/data_source/movie_database_datasource.dart';
import 'package:domain/domain.dart';

final class MoviesRepositoryImpl extends MoviesRepository {
  final MovieApiDataSource _apiDataSource;
  final MovieDatabaseDataSource _databaseDataSource;

  MoviesRepositoryImpl({
    required MovieApiDataSource apiDataSource,
    required MovieDatabaseDataSource databaseDataSource,
  }) : _apiDataSource = apiDataSource,
       _databaseDataSource = databaseDataSource;

  @override
  Stream<FavouriteStatusResult> changeMovieFavouriteStatus({
    required int id,
  }) async* {
    yield (FavouriteStatusLoading());
    final result = await _databaseDataSource.changeMovieFavouriteStatus(id: id);

    if (result.isRight) {
      yield (FavouriteStatusSuccess(isFavourite: result.right));
    } else {
      yield (FavouriteStatusFailed(error: FavouriteGenericError()));
    }
  }

  @override
  Stream<MovieDetailsResult> fetchMovieDetails({required int id}) async* {
    yield (MovieDetailsLoading());
    final result = await _apiDataSource.fetchMovieDetails(id: id);

    if (result.isRight) {
      yield (MovieDetailsSuccess(movieDetails: result.right.toDomain()));
    } else {
      yield (MovieDetailsFailed(error: MovieDetailsApiError()));
    }
  }

  @override
  Stream<MoviesResult> fetchMoviePage({
    required String searchText,
    required int cursor,
  }) async* {
    yield (MoviesLoading(nextPageCursor: cursor));
    if (cursor == 1) {
      await _databaseDataSource.clearMoviesCache();
    }

    final result = await _apiDataSource.fetchPage(
      searchText: searchText,
      cursor: cursor,
    );

    if (result.isRight) {
      await _databaseDataSource.cacheMovies(page: result.right);
      yield (MoviesSuccess(nextPageCursor: result.right.ordinal + 1));
    } else {
      yield (MoviesFailed(error: MoviesApiError(), nextPageCursor: cursor));
    }
  }

  @override
  Stream<List<Movie>> observeFavouriteMovies() => _databaseDataSource
      .observeFavouriteMovies()
      .map((movies) => movies.map((movie) => movie.toDomain()).toList());

  @override
  Stream<bool> observeMovieFavouriteStatus({required int id}) =>
      _databaseDataSource.observeMovieFavouriteStatus(id: id);

  @override
  Stream<List<Movie>> observeMovies() => _databaseDataSource
      .observeMovies()
      .map((movies) => movies.map((movie) => movie.toDomain()).toList());
}
