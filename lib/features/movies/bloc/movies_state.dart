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

  factory MoviesListState.init() =>
      MoviesListStateLoading(movies: [], pageCursor: 1);

  const MoviesListState({required this.movies});

  bool get isLoading => this is MoviesListStateLoading;

  bool get isFailed => this is MoviesListStateFailed;

  bool get isSuccess => this is MoviesListStateSuccess;

  MoviesListStateSuccess? get asSuccessOrNull =>
      this is MoviesListStateSuccess ? this as MoviesListStateSuccess : null;

  MoviesListStateFailed? get asFailedOrNull =>
      this is MoviesListStateFailed ? this as MoviesListStateFailed : null;

  MoviesListState copyToLoading({
    List<Movie>? movies,
    required int pageCursor,
  }) => MoviesListStateLoading(
    pageCursor: pageCursor,
    movies: movies ?? this.movies,
  );

  MoviesListState copyToFailed({
    List<Movie>? movies,
    required int pageCursor,
    required MoviesError error,
  }) => MoviesListStateFailed(
    error: error,
    pageCursor: pageCursor,
    movies: movies ?? this.movies,
  );

  MoviesListState copyToSuccess({
    List<Movie>? movies,
    required Optional<int>? nextPageCursor,
  }) => MoviesListStateSuccess(
    nextPageCursor: nextPageCursor?.value,
    movies: movies ?? this.movies,
  );
}

final class MoviesListStateLoading extends MoviesListState {
  const MoviesListStateLoading({
    required this.pageCursor,
    required super.movies,
  });

  final int pageCursor;

  @override
  List<Object?> get props => [movies, pageCursor];
}

final class MoviesListStateFailed extends MoviesListState {
  final MoviesError error;
  final int pageCursor;

  const MoviesListStateFailed({
    required this.error,
    required super.movies,
    required this.pageCursor,
  });

  @override
  List<Object?> get props => [error, movies, pageCursor];
}

final class MoviesListStateSuccess extends MoviesListState {
  const MoviesListStateSuccess({
    required this.nextPageCursor,
    required super.movies,
  });

  final int? nextPageCursor;

  @override
  List<Object?> get props => [movies, nextPageCursor];
}
