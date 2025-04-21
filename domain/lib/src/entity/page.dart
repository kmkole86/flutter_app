import 'package:equatable/equatable.dart';

import 'movie.dart';

final class Page extends Equatable {
  final int ordinal;
  final int totalPages;
  final int totalResults;
  final List<Movie> movies;

  const Page({
    required this.ordinal,
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  @override
  List<Object?> get props => [ordinal, totalPages, totalResults, movies];
}
