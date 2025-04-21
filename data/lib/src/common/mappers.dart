import 'package:data/src/model/movie_details_data.dart';
import 'package:data/src/model/movie_genre_data.dart';
import 'package:data/src/model/movie_with_favourite_data.dart';
import 'package:data/src/model/production_country_data.dart';
import 'package:data/src/model/spoken_language_data.dart';
import 'package:domain/domain.dart';

extension MovieDataExtension on MovieWithFavouriteData {
  Movie toDomain() => Movie(
    id: movie.id,
    title: movie.title,
    overview: movie.overview,
    posterPath: movie.posterPath,
    releaseDate: movie.releaseDate,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount,
    isFavourite: isFavourite,
  );
}

extension MovieDetailsDataExtension on MovieDetailsData {
  MovieDetails toDomain() => MovieDetails(
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
    genres: genres.map((e) => e.toDomain()).toList(),
    spokenLanguages: spokenLanguages.map((e) => e.toDomain()).toList(),
    productionCountries:
        productionCountries.map((e) => e.toDomain()).toList(),
  );
}

extension SpokenLanguageDataExtension on SpokenLanguageData {
  SpokenLanguage toDomain() =>
      SpokenLanguage(englishName: englishName, isoCode: isoCode, name: name);
}

extension MovieGenreDataExtension on MovieGenreData {
  MovieGenre toDomain() => MovieGenre(id: id, name: name);
}

extension ProductionCountryDataExtension on ProductionCountryData {
  ProductionCountry toDomain() =>
      ProductionCountry(isoCode: isoCode, name: name);
}
