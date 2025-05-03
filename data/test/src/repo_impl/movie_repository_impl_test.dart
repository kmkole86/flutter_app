import 'package:data/src/data_source/movie_api_datasource.dart';
import 'package:data/src/data_source/movie_database_datasource.dart';
import 'package:data/src/model/movie_data.dart';
import 'package:data/src/model/movie_page_data.dart';
import 'package:data/src/repo_impl/movie_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MovieApiDataSource>(),
  MockSpec<MovieDatabaseDataSource>(),
])
void main() {
  provideDummy<Either<FavouriteStatusError, bool>>(Right(false));
  provideDummy<Either<MoviesError, PageData>>(Right(_page()));

  late MockMovieApiDataSource apiDataSource;
  late MockMovieDatabaseDataSource databaseDataSource;
  late MoviesRepository repository;

  setUp(() {
    apiDataSource = MockMovieApiDataSource();
    databaseDataSource = MockMovieDatabaseDataSource();
    repository = MoviesRepositoryImpl(
      apiDataSource: apiDataSource,
      databaseDataSource: databaseDataSource,
    );
  });

  test('repository should change favourite status', () async {
    await repository.changeMovieFavouriteStatus(id: 5).toList();

    verify(databaseDataSource.changeMovieFavouriteStatus(id: 5));
  });

  test(
    'repository should emit Loading, Success when favourite status changed successfully',
    () async {
      when(
        databaseDataSource.changeMovieFavouriteStatus(id: anyNamed("id")),
      ).thenAnswer((_) async => Right(true));

      final result =
          await repository.changeMovieFavouriteStatus(id: 5).toList();

      expect([
        FavouriteStatusLoading(),
        FavouriteStatusSuccess(isFavourite: true),
      ], result);
    },
  );

  test(
    'repository should emit Loading, Failed when favourite status change is unsuccessful',
    () async {
      when(
        databaseDataSource.changeMovieFavouriteStatus(id: anyNamed("id")),
      ).thenAnswer((_) async => Left(FavouriteGenericError()));

      final result =
          await repository.changeMovieFavouriteStatus(id: 5).toList();

      expect([
        FavouriteStatusLoading(),
        FavouriteStatusFailed(error: FavouriteGenericError()),
      ], result);
    },
  );

  test('repository should fetch new movies page', () async {
    when(
      apiDataSource.fetchPage(
        searchText: anyNamed("searchText"),
        cursor: anyNamed("cursor"),
      ),
    ).thenAnswer((_) async => Right(_page()));

    await repository.fetchMoviePage(text: "fun", pageCursor: 1).toList();

    verify(apiDataSource.fetchPage(searchText: "fun", cursor: 1));
  });

  test(
    'repository should cache movies if fetch new movies page is successful',
    () async {
      when(
        apiDataSource.fetchPage(
          searchText: anyNamed("searchText"),
          cursor: anyNamed("cursor"),
        ),
      ).thenAnswer((_) async => Right(_page()));

      await repository.fetchMoviePage(text: "fun", pageCursor: 1).toList();

      verify(databaseDataSource.cacheMovies(page: _page()));
    },
  );

  test(
    'repository should emit Loading, Success when fetch new movies page is successful',
    () async {
      when(
        apiDataSource.fetchPage(
          searchText: anyNamed("searchText"),
          cursor: anyNamed("cursor"),
        ),
      ).thenAnswer((_) async => Right(_page()));

      final result =
          await repository.fetchMoviePage(text: "fun", pageCursor: 1).toList();

      expect([
        MoviesLoading(pageCursor: 1),
        MoviesSuccess(nextPageCursor: 2),
      ], result);
    },
  );

  test(
    'repository should emit Loading, Failed when fetch new movies page is unsuccessful',
    () async {
      when(
        apiDataSource.fetchPage(
          searchText: anyNamed("searchText"),
          cursor: anyNamed("cursor"),
        ),
      ).thenAnswer((_) async => Left(MoviesApiError()));

      final result =
          await repository.fetchMoviePage(text: "fun", pageCursor: 1).toList();

      expect([
        MoviesLoading(pageCursor: 1),
        MoviesFailed(error: MoviesApiError(), pageCursor: 1),
      ], result);
    },
  );
}

const List<MovieData> _movies = [
  MovieData(
    id: 1,
    title: "title 1",
    overview: "overview 1",
    posterPath: "posterPath 1",
    releaseDate: "releaseDate 1",
    voteAverage: 1.0,
    voteCount: 1,
  ),
  MovieData(
    id: 2,
    title: "title 2",
    overview: "overview 2",
    posterPath: "posterPath 2",
    releaseDate: "releaseDate 2",
    voteAverage: 2.0,
    voteCount: 2,
  ),
  MovieData(
    id: 3,
    title: "title 3",
    overview: "overview 3",
    posterPath: "posterPath 3",
    releaseDate: "releaseDate 3",
    voteAverage: 3.0,
    voteCount: 3,
  ),
  MovieData(
    id: 4,
    title: "title 4",
    overview: "overview 4",
    posterPath: "posterPath 4",
    releaseDate: "releaseDate 4",
    voteAverage: 4.0,
    voteCount: 4,
  ),
  MovieData(
    id: 5,
    title: "title 5",
    overview: "overview 5",
    posterPath: "posterPath 5",
    releaseDate: "releaseDate 5",
    voteAverage: 5.0,
    voteCount: 5,
  ),
];

PageData _page({
  int ordinal = 1,
  int totalPages = 10,
  int totalResults = 100,
  List<MovieData> movies = _movies,
}) => PageData(
  ordinal: ordinal,
  movies: movies,
  totalPages: totalPages,
  totalResults: totalResults,
);
