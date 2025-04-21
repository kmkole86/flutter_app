import 'package:data/src/database/flutter_app_database.dart';
import 'package:data/src/model/movie_data.dart';

extension MovieDbExtensions on MovieDb {
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
