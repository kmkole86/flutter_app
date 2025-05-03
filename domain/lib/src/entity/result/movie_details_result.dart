import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

sealed class MovieDetailsResult {
  bool get isFailed => this is MovieDetailsFailed;
}

final class MovieDetailsLoading extends MovieDetailsResult {}

final class MovieDetailsSuccess extends MovieDetailsResult with EquatableMixin {
  final MovieDetails movieDetails;

  MovieDetailsSuccess({required this.movieDetails});

  @override
  List<Object?> get props => [movieDetails];
}

final class MovieDetailsFailed extends MovieDetailsResult with EquatableMixin {
  final MovieDetailsError error;

  MovieDetailsFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

sealed class MovieDetailsError extends Equatable {}

final class MovieDetailsGenericError extends MovieDetailsError {
  @override
  List<Object?> get props => [];
}

final class MovieDetailsApiError extends MovieDetailsError {
  final int? errCode;

  MovieDetailsApiError({this.errCode});

  @override
  List<Object?> get props => [errCode];
}
