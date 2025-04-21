import 'package:data/src/model/movie_details_data.dart';
import 'package:data/src/model/movie_page_data.dart';
import 'package:domain/domain.dart';
import 'package:either_dart/either.dart';

abstract class MovieApiDataSource {
  Future<Either<MoviesError, PageData>> fetchPage({
    required String searchText,
    required int cursor,
  });

  Future<Either<MovieDetailsError, MovieDetailsData>> fetchMovieDetails({
    required int id,
  });
}
