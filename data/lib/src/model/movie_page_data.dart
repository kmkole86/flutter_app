import 'package:equatable/equatable.dart';

import 'movie_data.dart';

final class PageData extends Equatable {
  final int ordinal;
  final List<MovieData> movies;
  final int totalPages;
  final int totalResults;

  const PageData({
    required this.ordinal,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  @override
  List<Object?> get props => [ordinal, movies, totalPages, totalResults];
}
