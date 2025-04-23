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

  final StreamController<Query> _query = StreamController();

  late StreamSubscription<MovieFetchWithCacheResult> subscription;
  late Stream<MovieFetchWithCacheResult> _result;

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

    _result = _query.stream
        .debounceTime(Duration(microseconds: 300))
        .map(
          (query) => query.text.length >= 3 ? query : query.copyWith(text: ""),
        )
        .distinct()
        .switchMap(
          (query) => _combineLatest(
            fetchResultStream: _moviesRepository.fetchMoviePage(
              text: query.text,
              pageCursor: query.pageCursor,
            ),
            cacheResultStream: _moviesRepository.observeMovies(),
          ),
        );

    subscription = _result.listen((result) {
      add(MovieDataEvent(result: result));
    });

    add(GetInitDataEvent());
  }

  void _handleGetInitDataEvent(
    GetInitDataEvent event,
    Emitter<MoviesState> emit,
  ) {
    _query.add(Query(text: ""));
  }

  void _handleMovieDataEvent(MovieDataEvent event, Emitter<MoviesState> emit) {
    switch (event.result.fetchResult) {
      case MoviesLoading(pageCursor: final pageCursor):
        emit(
          state.copyWith(
            moviesListState: state.moviesListState.copyToLoading(
              movies: pageCursor == 1 ? [] : event.result.cacheResult,
              pageCursor: pageCursor,
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
      case MoviesFailed(error: final error, pageCursor: final pageCursor):
        emit(
          state.copyWith(
            moviesListState: state.moviesListState.copyToFailed(
              error: error,
              pageCursor: pageCursor,
            ),
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
    _query.add(Query(text: event.searchText));
  }

  void _handleMoviesBottomOfPageReachedEvent(
    MoviesBottomOfPageReachedEvent event,
    Emitter<MoviesState> emit,
  ) {
    if (state.moviesListState.asSuccessOrNull?.nextPageCursor != null) {
      _query.add(
        Query(
          text: state.searchText,
          pageCursor: state.moviesListState.asSuccessOrNull!.nextPageCursor!,
        ),
      );
    }
  }

  void _handleMoviesRetryEvent(
    MoviesRetryEvent event,
    Emitter<MoviesState> emit,
  ) {
    if (state.moviesListState.asSuccessOrNull != null) {
      _query.add(
        Query(
          text: state.searchText,
          pageCursor: state.moviesListState.asFailedOrNull!.pageCursor,
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
