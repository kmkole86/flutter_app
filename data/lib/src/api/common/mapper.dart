import 'package:data/src/api/model/movie_details_response.dart';
import 'package:data/src/api/model/movie_genre_response.dart';
import 'package:data/src/api/model/movie_response.dart';
import 'package:data/src/api/model/page_response.dart';
import 'package:data/src/api/model/production_country_response.dart';
import 'package:data/src/api/model/spoken_language_response.dart';
import 'package:data/src/model/movie_data.dart';
import 'package:data/src/model/movie_details_data.dart';
import 'package:data/src/model/movie_genre_data.dart';
import 'package:data/src/model/movie_page_data.dart';
import 'package:data/src/model/production_country_data.dart';
import 'package:data/src/model/spoken_language_data.dart';

extension PageResponseExtensions on PageResponse {
  PageData toData() => PageData(
    ordinal: ordinal,
    totalPages: totalPages,
    totalResults: totalResults,
    movies: movies.map((e) => e.toData()).toList(),
  );
}

extension MovieResponseExtensions on MovieResponse {
  MovieData toData() => MovieData(
    id: id,
    title: title,
    overview: overview,
    posterPath: posterPath,
    releaseDate: releaseDate,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}

extension MovieDetailsResponseExtensions on MovieDetailsResponse {
  MovieDetailsData toData() => MovieDetailsData(
    id: id,
    title: title,
    overview: overview,
    posterPath: posterPath,
    releaseDate: releaseDate,
    voteAverage: voteAverage,
    voteCount: voteCount,
    revenue: revenue,
    runtime: runtime,
    status: status,
    tagline: tagline,
    genres: genres.map((e) => e.toData()).toList(),
    spokenLanguages: spokenLanguages.map((e) => e.toData()).toList(),
    productionCountries: productionCountries.map((e) => e.toData()).toList(),
  );
}

extension SpokenLanguageResponseExtensions on SpokenLanguageResponse {
  SpokenLanguageData toData() => SpokenLanguageData(
    englishName: englishName,
    isoCode: isoCode,
    name: name,
  );
}

extension MovieGenreResponseExtensions on MovieGenreResponse {
  MovieGenreData toData() => MovieGenreData(id: id, name: name);
}

extension ProductionCountryResponseExtensions on ProductionCountryResponse {
  ProductionCountryData toData() =>
      ProductionCountryData(isoCode: isoCode, name: name);
}
