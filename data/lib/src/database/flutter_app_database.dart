import 'package:data/src/database/common/mappers.dart';
import 'package:data/src/database/model/favourite_index_db.dart';
import 'package:data/src/database/model/movie_db.dart';
import 'package:data/src/database/model/movie_index_db.dart';
import 'package:data/src/model/movie_data.dart';
import 'package:data/src/model/movie_with_favourite_data.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'flutter_app_database.g.dart';

@DriftDatabase(tables: [FavouriteIndexTbl, MoviesTbl, MovieIndexTbl])
class FlutterAppDatabase extends _$FlutterAppDatabase {
  FlutterAppDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'flutter_app_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<void> cacheMovies({
    required int pageOrdinal,
    required List<MovieData> movies,
  }) async {
    await batch((batch) async {
      batch.insertAll(
        movieIndexTbl,
        movies.map((e) => MovieIndexDb(id: e.id)),
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        moviesTbl,
        movies.map(
          (e) => MovieDb(
            id: e.id,
            title: e.title,
            overview: e.overview,
            posterPath: e.posterPath,
            releaseDate: e.releaseDate,
            voteAverage: e.voteAverage,
            voteCount: e.voteCount,
            pageOrdinal: pageOrdinal,
          ),
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> clearMoviesCache() => transaction(() async {
    await delete(movieIndexTbl).go();
    await (delete(moviesTbl)
      ..where((tbl) => tbl.id.isNotInQuery(select(favouriteIndexTbl)))).go();
  });

  Stream<List<MovieWithFavouriteData>> observeMovies() {
    return (select(moviesTbl)..orderBy([
          (movie) => OrderingTerm(
            expression: movie.pageOrdinal,
            mode: OrderingMode.asc,
          ),
          (movie) =>
              OrderingTerm(expression: movie.title, mode: OrderingMode.asc),
        ]))
        .join([
          innerJoin(movieIndexTbl, moviesTbl.id.equalsExp(movieIndexTbl.id)),
          leftOuterJoin(
            favouriteIndexTbl,
            moviesTbl.id.equalsExp(favouriteIndexTbl.id),
          ),
        ])
        .watch()
        .map((rows) {
          return rows.map((row) {
            return MovieWithFavouriteData(
              movie: row.readTable(moviesTbl).toData(),
              isFavourite: row.readTableOrNull(favouriteIndexTbl) != null,
            );
          }).toList();
        });
  }

  Future<List<MovieWithFavouriteData>> getMovies() {
    return (select(moviesTbl)..orderBy([
          (movie) => OrderingTerm(
            expression: movie.pageOrdinal,
            mode: OrderingMode.asc,
          ),
          (movie) =>
              OrderingTerm(expression: movie.title, mode: OrderingMode.asc),
        ]))
        .join([
          innerJoin(movieIndexTbl, moviesTbl.id.equalsExp(movieIndexTbl.id)),
          leftOuterJoin(
            favouriteIndexTbl,
            moviesTbl.id.equalsExp(favouriteIndexTbl.id),
          ),
        ])
        .map((rows) {
          return MovieWithFavouriteData(
            movie: rows.readTable(moviesTbl).toData(),
            isFavourite: rows.readTableOrNull(favouriteIndexTbl) != null,
          );
        })
        .get();
  }

  Stream<List<MovieWithFavouriteData>> observeMovieFavourites() {
    return (select(moviesTbl)..orderBy([
          (movie) =>
              OrderingTerm(expression: movie.title, mode: OrderingMode.asc),
        ]))
        .join([
          innerJoin(
            favouriteIndexTbl,
            moviesTbl.id.equalsExp(favouriteIndexTbl.id),
          ),
        ])
        .watch()
        .map((rows) {
          return rows.map((row) {
            return MovieWithFavouriteData(
              movie: row.readTable(moviesTbl).toData(),
              isFavourite: true, //covered by inner join
            );
          }).toList();
        });
  }

  Future<bool> changeMovieFavouriteStatus({required int id}) async {
    if ((await ((select(
          favouriteIndexTbl,
        )..where((favourite) => favourite.id.equals(id))).getSingleOrNull())) ==
        null) {
      await into(favouriteIndexTbl).insert(FavouriteIndexDb(id: id));
    } else {
      await (delete(favouriteIndexTbl)
        ..where((favourite) => favourite.id.equals(id))).go();
    }

    return (await ((select(
          favouriteIndexTbl,
        )..where((favourite) => favourite.id.equals(id))).getSingleOrNull())) !=
        null;
  }

  Stream<bool> observeMovieFavouriteStatus({required int id}) {
    return (select(favouriteIndexTbl)
          ..where((favourite) => favourite.id.equals(id))
          ..limit(1))
        .watchSingleOrNull()
        .map((e) => e != null);
  }
}
