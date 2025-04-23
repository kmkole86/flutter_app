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
  final String text;
  final int pageCursor;

  const Query({required this.text, this.pageCursor = 1});

  Query copyWith({String? text, int? pageCursor}) =>
      Query(text: text ?? this.text, pageCursor: pageCursor ?? this.pageCursor);

  @override
  List<Object?> get props => [text, pageCursor];
}
