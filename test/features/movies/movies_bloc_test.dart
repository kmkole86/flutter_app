import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_app/features/movies/bloc/movies_bloc.dart';
import 'package:flutter_app/features/movies/bloc/movies_event.dart';
import 'package:flutter_app/features/movies/bloc/movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MoviesRepository>()])
void main() {
  final MockMoviesRepository repository = MockMoviesRepository();

  tearDown(() {
    reset(repository);
  });

  test('initial sate should be empty', () async {
    expect(MoviesBloc(moviesRepository: repository).state, MoviesState.init());
  });

  blocTest<MoviesBloc, MoviesState>(
    "should call fetch new page when bottom is reached if state si successful and has more pages",
    build: () => MoviesBloc(moviesRepository: repository),
    seed:
        () => MoviesState(
          searchText: "fun",
          moviesListState: MoviesListStateSuccess(
            nextPageCursor: 2,
            movies: [],
          ),
        ),
    act: (bloc) => bloc.add(MoviesBottomOfPageReachedEvent()),
    wait: const Duration(milliseconds: 2000),
    verify: (_) {
      verify(repository.fetchMoviePage(text: "fun", pageCursor: 2));
    },
  );

  blocTest<MoviesBloc, MoviesState>(
    "should NOT call fetch new page when bottom is reached if state is Loading",
    build: () => MoviesBloc(moviesRepository: repository),
    seed:
        () => MoviesState(
          searchText: "fun",
          moviesListState: MoviesListStateLoading(pageCursor: 2, movies: []),
        ),
    act: (bloc) => bloc.add(MoviesBottomOfPageReachedEvent()),
    wait: const Duration(milliseconds: 2000),
    verify: (_) {
      verifyNever(repository.fetchMoviePage(text: "fun", pageCursor: 2));
    },
  );

  blocTest<MoviesBloc, MoviesState>(
    "should NOT call fetch new page when bottom is reached if state is Error",
    build: () => MoviesBloc(moviesRepository: repository),
    seed:
        () => MoviesState(
          searchText: "fun",
          moviesListState: MoviesListStateFailed(
            error: MoviesGenericError(),
            pageCursor: 2,
            movies: [],
          ),
        ),
    act: (bloc) => bloc.add(MoviesBottomOfPageReachedEvent()),
    verify: (_) {
      verifyNever(repository.fetchMoviePage(text: "fun", pageCursor: 2));
    },
  );

  blocTest<MoviesBloc, MoviesState>(
    "should emit MoviesLoading, MoviesSuccess when fetch of new page is successful",
    setUp: () {
      when(repository.fetchMoviePage(text: "fun", pageCursor: 2)).thenAnswer(
        (_) => Stream.fromIterable([
          MoviesLoading(pageCursor: 2),
          MoviesSuccess(nextPageCursor: 3),
        ]),
      );
      when(
        repository.observeMovies(),
      ).thenAnswer((_) => Stream.fromIterable([[]]));
    },
    build: () {
      return MoviesBloc(moviesRepository: repository);
    },
    seed:
        () => MoviesState(
          searchText: "fun",
          moviesListState: MoviesListStateSuccess(
            nextPageCursor: 2,
            movies: [],
          ),
        ),
    act: (bloc) => bloc.add(MoviesBottomOfPageReachedEvent()),
    wait: const Duration(milliseconds: 2000),
    expect:
        () => <MoviesState>[
          MoviesState(
            searchText: "fun",
            moviesListState: MoviesListStateLoading(pageCursor: 2, movies: []),
          ),
          MoviesState(
            searchText: "fun",
            moviesListState: MoviesListStateSuccess(
              nextPageCursor: 3,
              movies: [],
            ),
          ),
        ],
  );

  blocTest<MoviesBloc, MoviesState>(
    "should emit MoviesLoading, MoviesFailed when fetch of new page is unsuccessful",
    setUp: () {
      when(repository.fetchMoviePage(text: "fun", pageCursor: 2)).thenAnswer(
        (_) => Stream.fromIterable([
          MoviesLoading(pageCursor: 2),
          MoviesFailed(pageCursor: 2, error: MoviesApiError()),
        ]),
      );
      when(
        repository.observeMovies(),
      ).thenAnswer((_) => Stream.fromIterable([[]]));
    },
    build: () {
      return MoviesBloc(moviesRepository: repository);
    },
    seed:
        () => MoviesState(
          searchText: "fun",
          moviesListState: MoviesListStateSuccess(
            nextPageCursor: 2,
            movies: [],
          ),
        ),
    act: (bloc) => bloc.add(MoviesBottomOfPageReachedEvent()),
    wait: const Duration(milliseconds: 2000),
    expect:
        () => <MoviesState>[
          MoviesState(
            searchText: "fun",
            moviesListState: MoviesListStateLoading(pageCursor: 2, movies: []),
          ),
          MoviesState(
            searchText: "fun",
            moviesListState: MoviesListStateFailed(
              pageCursor: 2,
              movies: [],
              error: MoviesApiError(),
            ),
          ),
        ],
  );
}
