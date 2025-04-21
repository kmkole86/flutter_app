import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

import 'model.dart';

sealed class MoviesEvent {}

final class GetInitDataEvent extends MoviesEvent {}

final class MovieDataEvent extends MoviesEvent with EquatableMixin {
  final MovieFetchWithCacheResult result;

  MovieDataEvent({required this.result});

  @override
  List<Object?> get props => [result];
}

final class ChangeMovieFavouriteStatusEvent extends MoviesEvent
    with EquatableMixin {
  final int id;

  ChangeMovieFavouriteStatusEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class MovieFavouriteStatusChangedEvent extends MoviesEvent
    with EquatableMixin {
  final FavouriteStatusResult result;

  MovieFavouriteStatusChangedEvent({required this.result});

  @override
  List<Object?> get props => [result];
}

final class MoviesSearchTextChangedEvent extends MoviesEvent
    with EquatableMixin {
  final String searchText;

  MoviesSearchTextChangedEvent({required this.searchText});

  @override
  List<Object?> get props => [searchText];
}

final class MoviesBottomOfPageReachedEvent extends MoviesEvent {}

final class MoviesRetryEvent extends MoviesEvent {}
