import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_country_response.g.dart';

@JsonSerializable()
final class ProductionCountryResponse extends Equatable {
  @JsonKey(name: "iso_3166_1")
  final String isoCode;
  @JsonKey(name: "name")
  final String name;

  const ProductionCountryResponse({required this.isoCode, required this.name});

  @override
  List<Object?> get props => [isoCode, name];

  factory ProductionCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryResponseToJson(this);
}
