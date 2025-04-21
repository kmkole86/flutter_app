import 'dart:io';

import 'package:data/src/api/common/mapper.dart';
import 'package:data/src/api/model/movie_details_response.dart';
import 'package:data/src/api/model/page_response.dart';
import 'package:data/src/data_source/movie_api_datasource.dart';
import 'package:data/src/model/movie_details_data.dart';
import 'package:data/src/model/movie_page_data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:either_dart/either.dart';

const _pageParameter = 'page';
const _queryParameter = 'query';

final class MovieApiDataSourceImpl extends MovieApiDataSource {
  final Dio _restClient;

  MovieApiDataSourceImpl({required Dio restClient}) : _restClient = restClient;

  @override
  Future<Either<MovieDetailsError, MovieDetailsData>> fetchMovieDetails({
    required int id,
  }) async {
    try {
      final response = await _restClient.get('movie/$id');
      if (response.statusCode != HttpStatus.ok) {
        return Left(MovieDetailsApiError());
      }

      return Right(MovieDetailsResponse.fromJson(response.data!).toData());
    } catch (e) {
      return Left(MovieDetailsGenericError());
    }
  }

  @override
  Future<Either<MoviesError, PageData>> fetchPage({
    required String searchText,
    required int cursor,
  }) async {
    try {
      final response =
          searchText.isEmpty
              ? await _restClient.get(
                'movie/top_rated',
                queryParameters: {
                  _pageParameter: "$cursor",
                  _queryParameter: searchText,
                },
              )
              : await _restClient.get(
                'search/movie',
                queryParameters: {
                  _pageParameter: "$cursor",
                  _queryParameter: searchText,
                },
              );
      if (response.statusCode != HttpStatus.ok) {
        return Left(MoviesApiError());
      }

      return Right(PageResponse.fromJson(response.data!).toData());
    } catch (e) {
      return Left(MoviesGenericError());
    }
  }
}
