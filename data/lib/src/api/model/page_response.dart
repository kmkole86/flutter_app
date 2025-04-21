import 'package:data/src/api/model/movie_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable()
final class PageResponse extends Equatable {
  @JsonKey(name: "page")
  final int ordinal;
  @JsonKey(name: "results")
  final List<MovieResponse> movies;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  const PageResponse({
    required this.ordinal,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  @override
  List<Object?> get props => [ordinal, movies, totalPages, totalResults];

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson(this);
}
