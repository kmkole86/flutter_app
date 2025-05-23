// Mocks generated by Mockito 5.4.6 from annotations
// in flutter_app/test/features/movies/movies_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:domain/src/entity/movie.dart' as _i4;
import 'package:domain/src/entity/result/favourite_status_result.dart' as _i6;
import 'package:domain/src/entity/result/movie_details_result.dart' as _i7;
import 'package:domain/src/entity/result/movie_result.dart' as _i5;
import 'package:domain/src/repository/movies_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [MoviesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRepository extends _i1.Mock implements _i2.MoviesRepository {
  @override
  _i3.Stream<List<_i4.Movie>> observeMovies() =>
      (super.noSuchMethod(
            Invocation.method(#observeMovies, []),
            returnValue: _i3.Stream<List<_i4.Movie>>.empty(),
            returnValueForMissingStub: _i3.Stream<List<_i4.Movie>>.empty(),
          )
          as _i3.Stream<List<_i4.Movie>>);

  @override
  _i3.Stream<_i5.MoviesResult> fetchMoviePage({
    required String? text,
    required int? pageCursor,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#fetchMoviePage, [], {
              #text: text,
              #pageCursor: pageCursor,
            }),
            returnValue: _i3.Stream<_i5.MoviesResult>.empty(),
            returnValueForMissingStub: _i3.Stream<_i5.MoviesResult>.empty(),
          )
          as _i3.Stream<_i5.MoviesResult>);

  @override
  _i3.Stream<_i6.FavouriteStatusResult> changeMovieFavouriteStatus({
    required int? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#changeMovieFavouriteStatus, [], {#id: id}),
            returnValue: _i3.Stream<_i6.FavouriteStatusResult>.empty(),
            returnValueForMissingStub:
                _i3.Stream<_i6.FavouriteStatusResult>.empty(),
          )
          as _i3.Stream<_i6.FavouriteStatusResult>);

  @override
  _i3.Stream<List<_i4.Movie>> observeFavouriteMovies() =>
      (super.noSuchMethod(
            Invocation.method(#observeFavouriteMovies, []),
            returnValue: _i3.Stream<List<_i4.Movie>>.empty(),
            returnValueForMissingStub: _i3.Stream<List<_i4.Movie>>.empty(),
          )
          as _i3.Stream<List<_i4.Movie>>);

  @override
  _i3.Stream<_i7.MovieDetailsResult> fetchMovieDetails({required int? id}) =>
      (super.noSuchMethod(
            Invocation.method(#fetchMovieDetails, [], {#id: id}),
            returnValue: _i3.Stream<_i7.MovieDetailsResult>.empty(),
            returnValueForMissingStub:
                _i3.Stream<_i7.MovieDetailsResult>.empty(),
          )
          as _i3.Stream<_i7.MovieDetailsResult>);

  @override
  _i3.Stream<bool> observeMovieFavouriteStatus({required int? id}) =>
      (super.noSuchMethod(
            Invocation.method(#observeMovieFavouriteStatus, [], {#id: id}),
            returnValue: _i3.Stream<bool>.empty(),
            returnValueForMissingStub: _i3.Stream<bool>.empty(),
          )
          as _i3.Stream<bool>);
}
