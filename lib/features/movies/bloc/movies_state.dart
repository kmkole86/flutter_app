import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/optional.dart';

final class MoviesState extends Equatable {
  final String searchText;
  final MoviesListState moviesListState;

  const MoviesState({required this.searchText, required this.moviesListState});

  factory MoviesState.init() =>
      MoviesState(searchText: '', moviesListState: MoviesListState.init());

  MoviesState copyWith({
    String? searchText,
    MoviesListState? moviesListState,
  }) => MoviesState(
    searchText: searchText ?? this.searchText,
    moviesListState: moviesListState ?? this.moviesListState,
  );

  @override
  List<Object?> get props => [searchText, moviesListState];
}

sealed class MoviesListState extends Equatable {
  final List<Movie> movies;
  final int? nextPageCursor;

  factory MoviesListState.init() =>
      MoviesListStateLoading(movies: [], nextPageCursor: 1);

  const MoviesListState({required this.nextPageCursor, required this.movies});

  bool get isLoading => this is MoviesListStateLoading;

  bool get isFailed => this is MoviesListStateFailed;

  bool get isSuccess => this is MoviesListStateSuccess;

  MoviesListState copyWith({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
    MoviesError? error,
  }) => switch (this) {
    MoviesListStateLoading() => copyToLoading(
      movies: movies ?? this.movies,
      nextPageCursor: nextPageCursor,
    ),
    MoviesListStateFailed(error: final currentError) => copyToFailed(
      movies: movies ?? this.movies,
      nextPageCursor: nextPageCursor,
      error: error ?? currentError,
    ),
    MoviesListStateSuccess() => copyToSuccess(
      nextPageCursor: nextPageCursor,
      movies: movies ?? this.movies,
    ),
  };

  MoviesListState copyToLoading({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
  }) => MoviesListStateLoading(
    nextPageCursor:
        nextPageCursor != null ? nextPageCursor.value : this.nextPageCursor,
    movies: movies ?? this.movies,
  );

  MoviesListState copyToFailed({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
    required MoviesError error,
  }) => MoviesListStateFailed(
    error: error,
    nextPageCursor:
        nextPageCursor != null ? nextPageCursor.value : this.nextPageCursor,
    movies: movies ?? this.movies,
  );

  MoviesListState copyToSuccess({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
  }) => MoviesListStateSuccess(
    nextPageCursor:
        nextPageCursor != null ? nextPageCursor.value : this.nextPageCursor,
    movies: movies ?? this.movies,
  );
}

final class MoviesListStateLoading extends MoviesListState {
  const MoviesListStateLoading({
    required super.nextPageCursor,
    required super.movies,
  });

  @override
  List<Object?> get props => [movies, nextPageCursor];
}

final class MoviesListStateFailed extends MoviesListState {
  final MoviesError error;

  const MoviesListStateFailed({
    required this.error,
    required super.movies,
    required super.nextPageCursor,
  });

  @override
  List<Object?> get props => [error, movies, nextPageCursor];
}

final class MoviesListStateSuccess extends MoviesListState {
  const MoviesListStateSuccess({
    required super.nextPageCursor,
    required super.movies,
  });

  @override
  List<Object?> get props => [movies, nextPageCursor];
}
