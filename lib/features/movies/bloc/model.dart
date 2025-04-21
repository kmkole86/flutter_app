import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

final class MovieFetchWithCacheResult extends Equatable {
  final MoviesResult fetchResult;
  final List<Movie> cacheResult;

  const MovieFetchWithCacheResult({
    required this.fetchResult,
    required this.cacheResult,
  });

  @override
  List<Object?> get props => [cacheResult, fetchResult];
}

final class Query extends Equatable {
  final String searchText;
  final int nextPageCursor;

  const Query({required this.searchText, this.nextPageCursor = 1});

  @override
  List<Object?> get props => [searchText, nextPageCursor];
}
