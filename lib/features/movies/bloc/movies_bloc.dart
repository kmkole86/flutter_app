import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_app/common/optional.dart';
import 'package:flutter_app/features/movies/bloc/movies_event.dart';
import 'package:flutter_app/features/movies/bloc/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'model.dart';

final class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository _moviesRepository;

  final StreamController<String> searchQuery = StreamController();
  final StreamController<Query> loadNextPage = StreamController();

  late StreamSubscription<MovieFetchWithCacheResult> subscription;
  late Stream<MovieFetchWithCacheResult> searchResult;

  MoviesBloc({required MoviesRepository moviesRepository})
    : _moviesRepository = moviesRepository,
      super(MoviesState.init()) {
    on<GetInitDataEvent>(_handleGetInitDataEvent);
    on<MovieDataEvent>(_handleMovieDataEvent);
    on<ChangeMovieFavouriteStatusEvent>(_handleChangeMovieFavouriteStatusEvent);
    on<MovieFavouriteStatusChangedEvent>(_handleOnMovieFavouriteStatusChanged);
    on<MoviesSearchTextChangedEvent>(_handleMoviesSearchTextChangedEvent);
    on<MoviesBottomOfPageReachedEvent>(_handleMoviesBottomOfPageReachedEvent);
    on<MoviesRetryEvent>(_handleMoviesRetryEvent);

    searchResult = searchQuery.stream
        .debounceTime(Duration(microseconds: 300))
        .map((searchText) => searchText.length >= 3 ? searchText : "")
        .distinct()
        .map((e) => Query(searchText: e, nextPageCursor: 1))
        .mergeWith([loadNextPage.stream])
        .switchMap(
          (query) => _combineLatest(
            fetchResultStream: _moviesRepository.fetchMoviePage(
              searchText: query.searchText,
              cursor: query.nextPageCursor,
            ),
            cacheResultStream: _moviesRepository.observeMovies(),
          ),
        );

    subscription = searchResult.listen((result) {
      add(MovieDataEvent(result: result));
    });

    add(GetInitDataEvent());
  }

  void _handleGetInitDataEvent(
    GetInitDataEvent event,
    Emitter<MoviesState> emit,
  ) {
    searchQuery.add("");
  }

  void _handleMovieDataEvent(MovieDataEvent event, Emitter<MoviesState> emit) {
    switch (event.result.fetchResult) {
      case MoviesLoading():
        emit(
          state.copyWith(
            moviesListState: state.moviesListState.copyToLoading(
              movies:
                  event.result.fetchResult.nextPageCursor == 1
                      ? []
                      : event.result.cacheResult,
            ),
          ),
        );
      case MoviesSuccess(nextPageCursor: final nextPageCursor):
        emit(
          state.copyWith(
            moviesListState: state.moviesListState.copyToSuccess(
              nextPageCursor: Optional(value: nextPageCursor),
              movies: event.result.cacheResult,
            ),
          ),
        );
      case MoviesFailed(error: final error):
        emit(
          state.copyWith(
            moviesListState: state.moviesListState.copyToFailed(error: error),
          ),
        );
    }
  }

  void _handleChangeMovieFavouriteStatusEvent(
    ChangeMovieFavouriteStatusEvent event,
    Emitter<MoviesState> emit,
  ) {
    _moviesRepository.changeMovieFavouriteStatus(id: event.id).listen((data) {
      add(MovieFavouriteStatusChangedEvent(result: data));
    });
  }

  void _handleOnMovieFavouriteStatusChanged(
    MovieFavouriteStatusChangedEvent event,
    Emitter<MoviesState> emit,
  ) async {
    switch (event.result) {
      case FavouriteStatusSuccess(isFavourite: final isFavourite):
      case FavouriteStatusLoading():
      case FavouriteStatusFailed():
        //TODO implement
        ;
    }
  }

  void _handleMoviesSearchTextChangedEvent(
    MoviesSearchTextChangedEvent event,
    Emitter<MoviesState> emit,
  ) {
    emit(state.copyWith(searchText: event.searchText));
    searchQuery.add(event.searchText);
  }

  void _handleMoviesBottomOfPageReachedEvent(
    MoviesBottomOfPageReachedEvent event,
    Emitter<MoviesState> emit,
  ) {
    if (state.moviesListState.isSuccess &&
        state.moviesListState.nextPageCursor != null) {
      loadNextPage.add(
        Query(
          searchText: state.searchText,
          nextPageCursor: state.moviesListState.nextPageCursor ?? 1,
        ),
      );
    }
  }

  void _handleMoviesRetryEvent(
    MoviesRetryEvent event,
    Emitter<MoviesState> emit,
  ) {
    if (state.moviesListState.isFailed) {
      loadNextPage.add(
        Query(
          searchText: state.searchText,
          nextPageCursor: state.moviesListState.nextPageCursor ?? 1,
        ),
      );
    }
  }

  Stream<MovieFetchWithCacheResult> _combineLatest({
    required Stream<MoviesResult> fetchResultStream,
    required Stream<List<Movie>> cacheResultStream,
  }) => CombineLatestStream.combine2<
    MoviesResult,
    List<Movie>,
    MovieFetchWithCacheResult
  >(
    fetchResultStream,
    cacheResultStream,
    (fetchResult, cacheResult) => MovieFetchWithCacheResult(
      fetchResult: fetchResult,
      cacheResult: cacheResult,
    ),
  );

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
