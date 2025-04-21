import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spoken_language_response.g.dart';

@JsonSerializable()
final class SpokenLanguageResponse extends Equatable {
  @JsonKey(name: "english_name")
  final String englishName;
  @JsonKey(name: "iso_639_1")
  final String isoCode;
  @JsonKey(name: "name")
  final String name;

  const SpokenLanguageResponse({
    required this.englishName,
    required this.isoCode,
    required this.name,
  });

  @override
  List<Object?> get props => [isoCode, name, englishName];

  factory SpokenLanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageResponseToJson(this);
}
