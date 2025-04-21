import 'dart:async';
import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:flutter_app/features/favourites/bloc/favourites_event.dart';
import 'package:flutter_app/features/favourites/bloc/favourites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final MoviesRepository _moviesRepository;

  late StreamSubscription<List<Movie>> subscription;

  FavouritesBloc({required MoviesRepository moviesRepository})
    : _moviesRepository = moviesRepository,
      super(FavouritesStatusLoading()) {
    on<FavouritesDataEvent>(_handleFavouritesDataEvent);
    on<ChangeMovieFavouriteStatusEvent>(_handleChangeMovieFavouriteStatusEvent);
    on<MovieFavouriteStatusChangedEvent>(_handleOnMovieFavouriteStatusChanged);

    subscription = moviesRepository.observeFavouriteMovies().listen((data) {
      add(FavouritesDataEvent(favourites: data));
    });
  }

  void _handleFavouritesDataEvent(
    FavouritesDataEvent event,
    Emitter<FavouritesState> emit,
  ) {
    emit(FavouritesStatusSuccess(movies: event.favourites));
  }

  void _handleChangeMovieFavouriteStatusEvent(
    ChangeMovieFavouriteStatusEvent event,
    Emitter<FavouritesState> emit,
  ) {
    _moviesRepository.changeMovieFavouriteStatus(id: event.id).listen((data) {
      add(MovieFavouriteStatusChangedEvent(result: data));
    });
  }

  void _handleOnMovieFavouriteStatusChanged(
    MovieFavouriteStatusChangedEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    switch (event.result) {
      case FavouriteStatusSuccess(isFavourite: final isFavourite):
      case FavouriteStatusLoading():
      case FavouriteStatusFailed():
      //TODO implement
        ;
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
