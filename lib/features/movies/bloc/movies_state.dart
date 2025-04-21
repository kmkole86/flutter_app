import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/common/optional.dart';

sealed class MoviesState extends Equatable {
  final List<Movie> movies;
  final int? nextPageCursor;
  final String searchText;

  factory MoviesState.init() =>
      MoviesStateLoading(movies: [], nextPageCursor: 1, searchText: '');

  const MoviesState({
    required this.searchText,
    required this.nextPageCursor,
    required this.movies,
  });

  bool get isLoading => this is MoviesStateLoading;

  bool get isFailed => this is MoviesStateFailed;

  bool get isSuccess => this is MoviesStateSuccess;

  MoviesState copyWith({
    String? searchText,
    List<Movie>? movies,
    MoviesError? error,
  }) => switch (this) {
    MoviesStateLoading() => copyToLoading(
      searchText: searchText ?? this.searchText,
      movies: movies ?? this.movies,
    ),
    MoviesStateFailed(error: final currentError) => copyToFailed(
      searchText: searchText ?? this.searchText,
      movies: movies ?? this.movies,
      error: error ?? currentError,
    ),
    MoviesStateSuccess() => copyToSuccess(
      searchText: searchText ?? this.searchText,
      movies: movies ?? this.movies,
    ),
  };

  MoviesState copyToLoading({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
    String? searchText,
  }) => MoviesStateLoading(
    nextPageCursor:
        nextPageCursor != null ? nextPageCursor.value : this.nextPageCursor,
    movies: movies ?? this.movies,
    searchText: searchText ?? this.searchText,
  );

  MoviesState copyToFailed({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
    String? searchText,
    required MoviesError error,
  }) => MoviesStateFailed(
    error: error,
    nextPageCursor:
        nextPageCursor != null ? nextPageCursor.value : this.nextPageCursor,
    movies: movies ?? this.movies,
    searchText: searchText ?? this.searchText,
  );

  MoviesState copyToSuccess({
    List<Movie>? movies,
    Optional<int>? nextPageCursor,
    String? searchText,
  }) => MoviesStateSuccess(
    nextPageCursor:
        nextPageCursor != null ? nextPageCursor.value : this.nextPageCursor,
    movies: movies ?? this.movies,
    searchText: searchText ?? this.searchText,
  );
}

final class MoviesStateLoading extends MoviesState {
  const MoviesStateLoading({
    required super.nextPageCursor,
    required super.movies,
    required super.searchText,
  });

  @override
  List<Object?> get props => [movies, nextPageCursor, searchText];
}

final class MoviesStateFailed extends MoviesState {
  final MoviesError error;

  const MoviesStateFailed({
    required this.error,
    required super.movies,
    required super.nextPageCursor,
    required super.searchText,
  });

  @override
  List<Object?> get props => [error, movies, nextPageCursor, searchText];
}

final class MoviesStateSuccess extends MoviesState {
  const MoviesStateSuccess({
    required super.nextPageCursor,
    required super.movies,
    required super.searchText,
  });

  @override
  List<Object?> get props => [movies, nextPageCursor, searchText];
}
