import 'package:data/src/model/movie_data.dart';
import 'package:equatable/equatable.dart';

final class MovieWithFavouriteData extends Equatable {
  final MovieData movie;
  final bool isFavourite;

  const MovieWithFavouriteData({
    required this.movie,
    required this.isFavourite,
  });

  @override
  List<Object?> get props => [movie, isFavourite];
}
