import 'package:drift/drift.dart';

@DataClassName('FavouriteIndexDb')
class FavouriteIndexTbl extends Table {
  IntColumn get id => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
