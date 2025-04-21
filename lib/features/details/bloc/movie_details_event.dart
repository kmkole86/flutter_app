import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

sealed class MovieDetailsEvent {}

final class GetInitDataEvent extends MovieDetailsEvent {}

final class MovieDetailsDataEvent extends MovieDetailsEvent
    with EquatableMixin {
  final MovieDetailsResult result;

  MovieDetailsDataEvent({required this.result});

  @override
  List<Object?> get props => [result];
}

final class MovieFavouriteDataEvent extends MovieDetailsEvent
    with EquatableMixin {
  final bool isFavourite;

  MovieFavouriteDataEvent({required this.isFavourite});

  @override
  List<Object?> get props => [isFavourite];
}

final class ChangeMovieFavouriteStatusEvent extends MovieDetailsEvent {
  ChangeMovieFavouriteStatusEvent();
}

final class MovieFavouriteStatusChangedEvent extends MovieDetailsEvent
    with EquatableMixin {
  final FavouriteStatusResult result;

  MovieFavouriteStatusChangedEvent({required this.result});

  @override
  List<Object?> get props => [result];
}

final class RetryEvent extends MovieDetailsEvent {}
