import 'package:equatable/equatable.dart';

sealed class MoviesResult extends Equatable {
  const MoviesResult();
}

final class MoviesLoading extends MoviesResult {
  final int pageCursor;

  const MoviesLoading({required this.pageCursor});

  @override
  List<Object?> get props => [pageCursor];
}

final class MoviesSuccess extends MoviesResult {
  const MoviesSuccess({required this.nextPageCursor});

  final int? nextPageCursor;

  factory MoviesSuccess.empty() => MoviesSuccess(nextPageCursor: null);

  @override
  List<Object?> get props => [nextPageCursor];
}

final class MoviesFailed extends MoviesResult {
  final int pageCursor;
  final MoviesError error;

  const MoviesFailed({required this.error, required this.pageCursor});

  @override
  List<Object?> get props => [pageCursor, error];
}

sealed class MoviesError extends Equatable {}

final class MoviesGenericError extends MoviesError {
  @override
  List<Object?> get props => [];
}

final class MoviesApiError extends MoviesError {
  final int? errCode;

  MoviesApiError({this.errCode});

  @override
  List<Object?> get props => [errCode];
}
