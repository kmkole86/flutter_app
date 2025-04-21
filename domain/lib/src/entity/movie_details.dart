import 'package:domain/src/entity/production_country.dart';
import 'package:domain/src/entity/spoken_language.dart';
import 'package:equatable/equatable.dart';

import 'movie_genre.dart';

final class MovieDetails extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double revenue;
  final int runtime;
  final String status;
  final String tagline;
  final List<MovieGenre> genres;
  final List<SpokenLanguage> spokenLanguages;
  final List<ProductionCountry> productionCountries;

  const MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.genres,
    required this.spokenLanguages,
    required this.productionCountries,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    releaseDate,
    voteAverage,
    voteCount,
    revenue,
    runtime,
    status,
    tagline,
    genres,
    spokenLanguages,
    productionCountries,
  ];
}
