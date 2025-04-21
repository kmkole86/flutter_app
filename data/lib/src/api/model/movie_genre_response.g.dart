// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_genre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieGenreResponse _$MovieGenreResponseFromJson(Map<String, dynamic> json) =>
    MovieGenreResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$MovieGenreResponseToJson(MovieGenreResponse instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
