import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

sealed class FavouritesState {}

final class FavouritesStatusSuccess extends FavouritesState with EquatableMixin {
  final List<Movie> movies;

  FavouritesStatusSuccess({required this.movies});

  @override
  List<Object?> get props => [movies];
}

final class FavouritesStatusLoading extends FavouritesState {}
