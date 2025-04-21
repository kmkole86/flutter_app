import 'package:equatable/equatable.dart';

import 'movie_details_data.dart';

final class MovieDetailsWithFavouriteData extends Equatable {
  final MovieDetailsData movie;
  final bool isFavourite;

  const MovieDetailsWithFavouriteData({
    required this.movie,
    required this.isFavourite,
  });

  @override
  List<Object?> get props => [movie, isFavourite];
}
