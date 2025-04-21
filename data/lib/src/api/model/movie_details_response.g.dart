// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponse _$MovieDetailsResponseFromJson(
  Map<String, dynamic> json,
) => MovieDetailsResponse(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String,
  releaseDate: json['release_date'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  revenue: (json['revenue'] as num).toDouble(),
  runtime: (json['runtime'] as num).toInt(),
  status: json['status'] as String,
  tagline: json['tagline'] as String,
  genres:
      (json['genres'] as List<dynamic>)
          .map((e) => MovieGenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
  spokenLanguages:
      (json['spoken_languages'] as List<dynamic>)
          .map(
            (e) => SpokenLanguageResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  productionCountries:
      (json['production_countries'] as List<dynamic>)
          .map(
            (e) =>
                ProductionCountryResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$MovieDetailsResponseToJson(
  MovieDetailsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'overview': instance.overview,
  'poster_path': instance.posterPath,
  'release_date': instance.releaseDate,
  'vote_average': instance.voteAverage,
  'vote_count': instance.voteCount,
  'revenue': instance.revenue,
  'runtime': instance.runtime,
  'status': instance.status,
  'tagline': instance.tagline,
  'genres': instance.genres,
  'spoken_languages': instance.spokenLanguages,
  'production_countries': instance.productionCountries,
};
