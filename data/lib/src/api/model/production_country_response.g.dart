// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCountryResponse _$ProductionCountryResponseFromJson(
  Map<String, dynamic> json,
) => ProductionCountryResponse(
  isoCode: json['iso_3166_1'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$ProductionCountryResponseToJson(
  ProductionCountryResponse instance,
) => <String, dynamic>{'iso_3166_1': instance.isoCode, 'name': instance.name};
