import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

final class MovieDetailsState extends Equatable {
  final MovieDetailsResult movieDetails;
  final bool isFavourite;

  const MovieDetailsState({
    required this.movieDetails,
    required this.isFavourite,
  });

  factory MovieDetailsState.init() => MovieDetailsState(
    movieDetails: MovieDetailsLoading(),
    isFavourite: false,
  );

  MovieDetailsState copyWith({
    MovieDetailsResult? movieDetails,
    bool? isFavourite,
  }) => MovieDetailsState(
    movieDetails: movieDetails ?? this.movieDetails,
    isFavourite: isFavourite ?? this.isFavourite,
  );

  @override
  List<Object?> get props => [movieDetails, isFavourite];
}
