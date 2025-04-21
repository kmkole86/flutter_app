import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_app/features/details/bloc/movie_details_event.dart';
import 'package:flutter_app/features/details/bloc/movie_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final int _movieId;
  final MoviesRepository _moviesRepository;

  late StreamSubscription<bool> favouriteStatusSubscription;

  MovieDetailsBloc({
    required MoviesRepository moviesRepository,
    required int id,
  }) : _movieId = id,
       _moviesRepository = moviesRepository,
       super(MovieDetailsState.init()) {
    on<GetInitDataEvent>(_handleGetInitDataEvent);
    on<MovieDetailsDataEvent>(_handleMovieDetailsDataEvent);
    on<MovieFavouriteDataEvent>(_handleMovieFavouriteDataEvent);
    on<ChangeMovieFavouriteStatusEvent>(_handleChangeMovieFavouriteStatusEvent);
    on<MovieFavouriteStatusChangedEvent>(_handleOnMovieFavouriteStatusChanged);
    on<RetryEvent>(_handleRetryEvent);

    favouriteStatusSubscription = _moviesRepository
        .observeMovieFavouriteStatus(id: _movieId)
        .listen((data) {
          add(MovieFavouriteDataEvent(isFavourite: data));
        });

    add(GetInitDataEvent());
  }

  void _handleGetInitDataEvent(
    GetInitDataEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    _moviesRepository.fetchMovieDetails(id: _movieId).listen((data) {
      add(MovieDetailsDataEvent(result: data));
    });
  }

  void _handleMovieFavouriteDataEvent(
    MovieFavouriteDataEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(isFavourite: event.isFavourite));
  }

  void _handleChangeMovieFavouriteStatusEvent(
    ChangeMovieFavouriteStatusEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    _moviesRepository.changeMovieFavouriteStatus(id: _movieId).listen((data) {
      add(MovieFavouriteStatusChangedEvent(result: data));
    });
  }

  void _handleOnMovieFavouriteStatusChanged(
    MovieFavouriteStatusChangedEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    switch (event.result) {
      case FavouriteStatusSuccess(isFavourite: final isFavourite):
        emit(state.copyWith(isFavourite: isFavourite));
      case FavouriteStatusLoading():
      case FavouriteStatusFailed():
        //TODO implement
        ;
    }
  }

  void _handleMovieDetailsDataEvent(
    MovieDetailsDataEvent event,
    Emitter<MovieDetailsState> emit,
  ) {
    emit(state.copyWith(movieDetails: event.result));
  }

  void _handleRetryEvent(
    RetryEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (state.movieDetails.isFailed) {
      add(GetInitDataEvent());
    }
  }

  @override
  Future<void> close() {
    favouriteStatusSubscription.cancel();
    return super.close();
  }
}
