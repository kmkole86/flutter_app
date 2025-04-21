import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

sealed class FavouritesEvent {}

final class FavouritesDataEvent extends FavouritesEvent with EquatableMixin {
  final List<Movie> favourites;

  FavouritesDataEvent({required this.favourites});

  @override
  List<Object?> get props => [favourites];
}

final class ChangeMovieFavouriteStatusEvent extends FavouritesEvent
    with EquatableMixin {
  final int id;

  ChangeMovieFavouriteStatusEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class MovieFavouriteStatusChangedEvent extends FavouritesEvent
    with EquatableMixin {
  final FavouriteStatusResult result;

  MovieFavouriteStatusChangedEvent({required this.result});

  @override
  List<Object?> get props => [result];
}
