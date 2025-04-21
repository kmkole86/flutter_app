import 'package:drift/drift.dart';

@DataClassName('MovieIndexDb')
class MovieIndexTbl extends Table {
  IntColumn get id => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
