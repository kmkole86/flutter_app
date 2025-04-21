import 'package:drift/drift.dart';

@DataClassName('MovieWithFavouriteDb')
class MovieWithFavouriteTbl extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get overview => text()();

  TextColumn get posterPath => text().nullable()();

  TextColumn get releaseDate => text()();

  RealColumn get voteAverage => real()();

  IntColumn get voteCount => integer()();

  IntColumn get pageOrdinal => integer()();

  IntColumn get isFavourite => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
