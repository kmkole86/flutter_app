import 'package:data/src/api/model/production_country_response.dart';
import 'package:data/src/api/model/spoken_language_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie_genre_response.dart';

part 'movie_details_response.g.dart';

@JsonSerializable()
final class MovieDetailsResponse extends Equatable {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "overview")
  final String overview;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "release_date")
  final String releaseDate;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;
  @JsonKey(name: "revenue")
  final double revenue;
  @JsonKey(name: "runtime")
  final int runtime;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "tagline")
  final String tagline;
  @JsonKey(name: "genres")
  final List<MovieGenreResponse> genres;
  @JsonKey(name: "spoken_languages")
  final List<SpokenLanguageResponse> spokenLanguages;
  @JsonKey(name: "production_countries")
  final List<ProductionCountryResponse> productionCountries;

  const MovieDetailsResponse({
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

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);
}
