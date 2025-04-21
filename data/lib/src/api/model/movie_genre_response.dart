import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_genre_response.g.dart';

@JsonSerializable()
final class MovieGenreResponse extends Equatable {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;

  const MovieGenreResponse({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  factory MovieGenreResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieGenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieGenreResponseToJson(this);
}
