import 'package:equatable/equatable.dart';

sealed class MoviesResult extends Equatable {
  final int? nextPageCursor;

  const MoviesResult({required this.nextPageCursor});
}

final class MoviesLoading extends MoviesResult {
  const MoviesLoading({required super.nextPageCursor});

  @override
  List<Object?> get props => [nextPageCursor];
}

final class MoviesSuccess extends MoviesResult {
  const MoviesSuccess({required super.nextPageCursor});

  factory MoviesSuccess.empty() => MoviesSuccess(nextPageCursor: null);

  @override
  List<Object?> get props => [nextPageCursor];
}

final class MoviesFailed extends MoviesResult {
  final MoviesError error;

  const MoviesFailed({required this.error, required super.nextPageCursor});

  @override
  List<Object?> get props => [nextPageCursor, error];
}

sealed class MoviesError {}

final class MoviesGenericError extends MoviesError {}

final class MoviesApiError extends MoviesError with EquatableMixin {
  final int? errCode;

  MoviesApiError({this.errCode});

  @override
  List<Object?> get props => [errCode];
}
