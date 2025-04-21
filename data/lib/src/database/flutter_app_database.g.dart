// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_app_database.dart';

// ignore_for_file: type=lint
class $FavouriteIndexTblTable extends FavouriteIndexTbl
    with TableInfo<$FavouriteIndexTblTable, FavouriteIndexDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavouriteIndexTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favourite_index_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavouriteIndexDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavouriteIndexDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavouriteIndexDb(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
    );
  }

  @override
  $FavouriteIndexTblTable createAlias(String alias) {
    return $FavouriteIndexTblTable(attachedDatabase, alias);
  }
}

class FavouriteIndexDb extends DataClass
    implements Insertable<FavouriteIndexDb> {
  final int id;
  const FavouriteIndexDb({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  FavouriteIndexTblCompanion toCompanion(bool nullToAbsent) {
    return FavouriteIndexTblCompanion(id: Value(id));
  }

  factory FavouriteIndexDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavouriteIndexDb(id: serializer.fromJson<int>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<int>(id)};
  }

  FavouriteIndexDb copyWith({int? id}) => FavouriteIndexDb(id: id ?? this.id);
  FavouriteIndexDb copyWithCompanion(FavouriteIndexTblCompanion data) {
    return FavouriteIndexDb(id: data.id.present ? data.id.value : this.id);
  }

  @override
  String toString() {
    return (StringBuffer('FavouriteIndexDb(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavouriteIndexDb && other.id == this.id);
}

class FavouriteIndexTblCompanion extends UpdateCompanion<FavouriteIndexDb> {
  final Value<int> id;
  const FavouriteIndexTblCompanion({this.id = const Value.absent()});
  FavouriteIndexTblCompanion.insert({this.id = const Value.absent()});
  static Insertable<FavouriteIndexDb> custom({Expression<int>? id}) {
    return RawValuesInsertable({if (id != null) 'id': id});
  }

  FavouriteIndexTblCompanion copyWith({Value<int>? id}) {
    return FavouriteIndexTblCompanion(id: id ?? this.id);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavouriteIndexTblCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $MoviesTblTable extends MoviesTbl
    with TableInfo<$MoviesTblTable, MovieDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoviesTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageOrdinalMeta = const VerificationMeta(
    'pageOrdinal',
  );
  @override
  late final GeneratedColumn<int> pageOrdinal = GeneratedColumn<int>(
    'page_ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    overview,
    posterPath,
    releaseDate,
    voteAverage,
    voteCount,
    pageOrdinal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movies_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovieDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('page_ordinal')) {
      context.handle(
        _pageOrdinalMeta,
        pageOrdinal.isAcceptableOrUnknown(
          data['page_ordinal']!,
          _pageOrdinalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pageOrdinalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieDb(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      overview:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}overview'],
          )!,
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      ),
      releaseDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}release_date'],
          )!,
      voteAverage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}vote_average'],
          )!,
      voteCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}vote_count'],
          )!,
      pageOrdinal:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}page_ordinal'],
          )!,
    );
  }

  @override
  $MoviesTblTable createAlias(String alias) {
    return $MoviesTblTable(attachedDatabase, alias);
  }
}

class MovieDb extends DataClass implements Insertable<MovieDb> {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final int pageOrdinal;
  const MovieDb({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.pageOrdinal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    map['release_date'] = Variable<String>(releaseDate);
    map['vote_average'] = Variable<double>(voteAverage);
    map['vote_count'] = Variable<int>(voteCount);
    map['page_ordinal'] = Variable<int>(pageOrdinal);
    return map;
  }

  MoviesTblCompanion toCompanion(bool nullToAbsent) {
    return MoviesTblCompanion(
      id: Value(id),
      title: Value(title),
      overview: Value(overview),
      posterPath:
          posterPath == null && nullToAbsent
              ? const Value.absent()
              : Value(posterPath),
      releaseDate: Value(releaseDate),
      voteAverage: Value(voteAverage),
      voteCount: Value(voteCount),
      pageOrdinal: Value(pageOrdinal),
    );
  }

  factory MovieDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieDb(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      pageOrdinal: serializer.fromJson<int>(json['pageOrdinal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'posterPath': serializer.toJson<String?>(posterPath),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'voteCount': serializer.toJson<int>(voteCount),
      'pageOrdinal': serializer.toJson<int>(pageOrdinal),
    };
  }

  MovieDb copyWith({
    int? id,
    String? title,
    String? overview,
    Value<String?> posterPath = const Value.absent(),
    String? releaseDate,
    double? voteAverage,
    int? voteCount,
    int? pageOrdinal,
  }) => MovieDb(
    id: id ?? this.id,
    title: title ?? this.title,
    overview: overview ?? this.overview,
    posterPath: posterPath.present ? posterPath.value : this.posterPath,
    releaseDate: releaseDate ?? this.releaseDate,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
    pageOrdinal: pageOrdinal ?? this.pageOrdinal,
  );
  MovieDb copyWithCompanion(MoviesTblCompanion data) {
    return MovieDb(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
      pageOrdinal:
          data.pageOrdinal.present ? data.pageOrdinal.value : this.pageOrdinal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovieDb(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('pageOrdinal: $pageOrdinal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    overview,
    posterPath,
    releaseDate,
    voteAverage,
    voteCount,
    pageOrdinal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDb &&
          other.id == this.id &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount &&
          other.pageOrdinal == this.pageOrdinal);
}

class MoviesTblCompanion extends UpdateCompanion<MovieDb> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> overview;
  final Value<String?> posterPath;
  final Value<String> releaseDate;
  final Value<double> voteAverage;
  final Value<int> voteCount;
  final Value<int> pageOrdinal;
  const MoviesTblCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.pageOrdinal = const Value.absent(),
  });
  MoviesTblCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String overview,
    this.posterPath = const Value.absent(),
    required String releaseDate,
    required double voteAverage,
    required int voteCount,
    required int pageOrdinal,
  }) : title = Value(title),
       overview = Value(overview),
       releaseDate = Value(releaseDate),
       voteAverage = Value(voteAverage),
       voteCount = Value(voteCount),
       pageOrdinal = Value(pageOrdinal);
  static Insertable<MovieDb> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
    Expression<int>? pageOrdinal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (pageOrdinal != null) 'page_ordinal': pageOrdinal,
    });
  }

  MoviesTblCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? overview,
    Value<String?>? posterPath,
    Value<String>? releaseDate,
    Value<double>? voteAverage,
    Value<int>? voteCount,
    Value<int>? pageOrdinal,
  }) {
    return MoviesTblCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      pageOrdinal: pageOrdinal ?? this.pageOrdinal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (pageOrdinal.present) {
      map['page_ordinal'] = Variable<int>(pageOrdinal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesTblCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('pageOrdinal: $pageOrdinal')
          ..write(')'))
        .toString();
  }
}

class $MovieIndexTblTable extends MovieIndexTbl
    with TableInfo<$MovieIndexTblTable, MovieIndexDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieIndexTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movie_index_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovieIndexDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieIndexDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieIndexDb(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
    );
  }

  @override
  $MovieIndexTblTable createAlias(String alias) {
    return $MovieIndexTblTable(attachedDatabase, alias);
  }
}

class MovieIndexDb extends DataClass implements Insertable<MovieIndexDb> {
  final int id;
  const MovieIndexDb({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  MovieIndexTblCompanion toCompanion(bool nullToAbsent) {
    return MovieIndexTblCompanion(id: Value(id));
  }

  factory MovieIndexDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieIndexDb(id: serializer.fromJson<int>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<int>(id)};
  }

  MovieIndexDb copyWith({int? id}) => MovieIndexDb(id: id ?? this.id);
  MovieIndexDb copyWithCompanion(MovieIndexTblCompanion data) {
    return MovieIndexDb(id: data.id.present ? data.id.value : this.id);
  }

  @override
  String toString() {
    return (StringBuffer('MovieIndexDb(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is MovieIndexDb && other.id == this.id);
}

class MovieIndexTblCompanion extends UpdateCompanion<MovieIndexDb> {
  final Value<int> id;
  const MovieIndexTblCompanion({this.id = const Value.absent()});
  MovieIndexTblCompanion.insert({this.id = const Value.absent()});
  static Insertable<MovieIndexDb> custom({Expression<int>? id}) {
    return RawValuesInsertable({if (id != null) 'id': id});
  }

  MovieIndexTblCompanion copyWith({Value<int>? id}) {
    return MovieIndexTblCompanion(id: id ?? this.id);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieIndexTblCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

abstract class _$FlutterAppDatabase extends GeneratedDatabase {
  _$FlutterAppDatabase(QueryExecutor e) : super(e);
  $FlutterAppDatabaseManager get managers => $FlutterAppDatabaseManager(this);
  late final $FavouriteIndexTblTable favouriteIndexTbl =
      $FavouriteIndexTblTable(this);
  late final $MoviesTblTable moviesTbl = $MoviesTblTable(this);
  late final $MovieIndexTblTable movieIndexTbl = $MovieIndexTblTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favouriteIndexTbl,
    moviesTbl,
    movieIndexTbl,
  ];
}

typedef $$FavouriteIndexTblTableCreateCompanionBuilder =
    FavouriteIndexTblCompanion Function({Value<int> id});
typedef $$FavouriteIndexTblTableUpdateCompanionBuilder =
    FavouriteIndexTblCompanion Function({Value<int> id});

class $$FavouriteIndexTblTableFilterComposer
    extends Composer<_$FlutterAppDatabase, $FavouriteIndexTblTable> {
  $$FavouriteIndexTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavouriteIndexTblTableOrderingComposer
    extends Composer<_$FlutterAppDatabase, $FavouriteIndexTblTable> {
  $$FavouriteIndexTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavouriteIndexTblTableAnnotationComposer
    extends Composer<_$FlutterAppDatabase, $FavouriteIndexTblTable> {
  $$FavouriteIndexTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$FavouriteIndexTblTableTableManager
    extends
        RootTableManager<
          _$FlutterAppDatabase,
          $FavouriteIndexTblTable,
          FavouriteIndexDb,
          $$FavouriteIndexTblTableFilterComposer,
          $$FavouriteIndexTblTableOrderingComposer,
          $$FavouriteIndexTblTableAnnotationComposer,
          $$FavouriteIndexTblTableCreateCompanionBuilder,
          $$FavouriteIndexTblTableUpdateCompanionBuilder,
          (
            FavouriteIndexDb,
            BaseReferences<
              _$FlutterAppDatabase,
              $FavouriteIndexTblTable,
              FavouriteIndexDb
            >,
          ),
          FavouriteIndexDb,
          PrefetchHooks Function()
        > {
  $$FavouriteIndexTblTableTableManager(
    _$FlutterAppDatabase db,
    $FavouriteIndexTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FavouriteIndexTblTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$FavouriteIndexTblTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$FavouriteIndexTblTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({Value<int> id = const Value.absent()}) =>
                  FavouriteIndexTblCompanion(id: id),
          createCompanionCallback:
              ({Value<int> id = const Value.absent()}) =>
                  FavouriteIndexTblCompanion.insert(id: id),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavouriteIndexTblTableProcessedTableManager =
    ProcessedTableManager<
      _$FlutterAppDatabase,
      $FavouriteIndexTblTable,
      FavouriteIndexDb,
      $$FavouriteIndexTblTableFilterComposer,
      $$FavouriteIndexTblTableOrderingComposer,
      $$FavouriteIndexTblTableAnnotationComposer,
      $$FavouriteIndexTblTableCreateCompanionBuilder,
      $$FavouriteIndexTblTableUpdateCompanionBuilder,
      (
        FavouriteIndexDb,
        BaseReferences<
          _$FlutterAppDatabase,
          $FavouriteIndexTblTable,
          FavouriteIndexDb
        >,
      ),
      FavouriteIndexDb,
      PrefetchHooks Function()
    >;
typedef $$MoviesTblTableCreateCompanionBuilder =
    MoviesTblCompanion Function({
      Value<int> id,
      required String title,
      required String overview,
      Value<String?> posterPath,
      required String releaseDate,
      required double voteAverage,
      required int voteCount,
      required int pageOrdinal,
    });
typedef $$MoviesTblTableUpdateCompanionBuilder =
    MoviesTblCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> overview,
      Value<String?> posterPath,
      Value<String> releaseDate,
      Value<double> voteAverage,
      Value<int> voteCount,
      Value<int> pageOrdinal,
    });

class $$MoviesTblTableFilterComposer
    extends Composer<_$FlutterAppDatabase, $MoviesTblTable> {
  $$MoviesTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageOrdinal => $composableBuilder(
    column: $table.pageOrdinal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MoviesTblTableOrderingComposer
    extends Composer<_$FlutterAppDatabase, $MoviesTblTable> {
  $$MoviesTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageOrdinal => $composableBuilder(
    column: $table.pageOrdinal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoviesTblTableAnnotationComposer
    extends Composer<_$FlutterAppDatabase, $MoviesTblTable> {
  $$MoviesTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);

  GeneratedColumn<int> get pageOrdinal => $composableBuilder(
    column: $table.pageOrdinal,
    builder: (column) => column,
  );
}

class $$MoviesTblTableTableManager
    extends
        RootTableManager<
          _$FlutterAppDatabase,
          $MoviesTblTable,
          MovieDb,
          $$MoviesTblTableFilterComposer,
          $$MoviesTblTableOrderingComposer,
          $$MoviesTblTableAnnotationComposer,
          $$MoviesTblTableCreateCompanionBuilder,
          $$MoviesTblTableUpdateCompanionBuilder,
          (
            MovieDb,
            BaseReferences<_$FlutterAppDatabase, $MoviesTblTable, MovieDb>,
          ),
          MovieDb,
          PrefetchHooks Function()
        > {
  $$MoviesTblTableTableManager(_$FlutterAppDatabase db, $MoviesTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MoviesTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MoviesTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MoviesTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<String?> posterPath = const Value.absent(),
                Value<String> releaseDate = const Value.absent(),
                Value<double> voteAverage = const Value.absent(),
                Value<int> voteCount = const Value.absent(),
                Value<int> pageOrdinal = const Value.absent(),
              }) => MoviesTblCompanion(
                id: id,
                title: title,
                overview: overview,
                posterPath: posterPath,
                releaseDate: releaseDate,
                voteAverage: voteAverage,
                voteCount: voteCount,
                pageOrdinal: pageOrdinal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String overview,
                Value<String?> posterPath = const Value.absent(),
                required String releaseDate,
                required double voteAverage,
                required int voteCount,
                required int pageOrdinal,
              }) => MoviesTblCompanion.insert(
                id: id,
                title: title,
                overview: overview,
                posterPath: posterPath,
                releaseDate: releaseDate,
                voteAverage: voteAverage,
                voteCount: voteCount,
                pageOrdinal: pageOrdinal,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MoviesTblTableProcessedTableManager =
    ProcessedTableManager<
      _$FlutterAppDatabase,
      $MoviesTblTable,
      MovieDb,
      $$MoviesTblTableFilterComposer,
      $$MoviesTblTableOrderingComposer,
      $$MoviesTblTableAnnotationComposer,
      $$MoviesTblTableCreateCompanionBuilder,
      $$MoviesTblTableUpdateCompanionBuilder,
      (MovieDb, BaseReferences<_$FlutterAppDatabase, $MoviesTblTable, MovieDb>),
      MovieDb,
      PrefetchHooks Function()
    >;
typedef $$MovieIndexTblTableCreateCompanionBuilder =
    MovieIndexTblCompanion Function({Value<int> id});
typedef $$MovieIndexTblTableUpdateCompanionBuilder =
    MovieIndexTblCompanion Function({Value<int> id});

class $$MovieIndexTblTableFilterComposer
    extends Composer<_$FlutterAppDatabase, $MovieIndexTblTable> {
  $$MovieIndexTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MovieIndexTblTableOrderingComposer
    extends Composer<_$FlutterAppDatabase, $MovieIndexTblTable> {
  $$MovieIndexTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovieIndexTblTableAnnotationComposer
    extends Composer<_$FlutterAppDatabase, $MovieIndexTblTable> {
  $$MovieIndexTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$MovieIndexTblTableTableManager
    extends
        RootTableManager<
          _$FlutterAppDatabase,
          $MovieIndexTblTable,
          MovieIndexDb,
          $$MovieIndexTblTableFilterComposer,
          $$MovieIndexTblTableOrderingComposer,
          $$MovieIndexTblTableAnnotationComposer,
          $$MovieIndexTblTableCreateCompanionBuilder,
          $$MovieIndexTblTableUpdateCompanionBuilder,
          (
            MovieIndexDb,
            BaseReferences<
              _$FlutterAppDatabase,
              $MovieIndexTblTable,
              MovieIndexDb
            >,
          ),
          MovieIndexDb,
          PrefetchHooks Function()
        > {
  $$MovieIndexTblTableTableManager(
    _$FlutterAppDatabase db,
    $MovieIndexTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MovieIndexTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$MovieIndexTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MovieIndexTblTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({Value<int> id = const Value.absent()}) =>
                  MovieIndexTblCompanion(id: id),
          createCompanionCallback:
              ({Value<int> id = const Value.absent()}) =>
                  MovieIndexTblCompanion.insert(id: id),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MovieIndexTblTableProcessedTableManager =
    ProcessedTableManager<
      _$FlutterAppDatabase,
      $MovieIndexTblTable,
      MovieIndexDb,
      $$MovieIndexTblTableFilterComposer,
      $$MovieIndexTblTableOrderingComposer,
      $$MovieIndexTblTableAnnotationComposer,
      $$MovieIndexTblTableCreateCompanionBuilder,
      $$MovieIndexTblTableUpdateCompanionBuilder,
      (
        MovieIndexDb,
        BaseReferences<_$FlutterAppDatabase, $MovieIndexTblTable, MovieIndexDb>,
      ),
      MovieIndexDb,
      PrefetchHooks Function()
    >;

class $FlutterAppDatabaseManager {
  final _$FlutterAppDatabase _db;
  $FlutterAppDatabaseManager(this._db);
  $$FavouriteIndexTblTableTableManager get favouriteIndexTbl =>
      $$FavouriteIndexTblTableTableManager(_db, _db.favouriteIndexTbl);
  $$MoviesTblTableTableManager get moviesTbl =>
      $$MoviesTblTableTableManager(_db, _db.moviesTbl);
  $$MovieIndexTblTableTableManager get movieIndexTbl =>
      $$MovieIndexTblTableTableManager(_db, _db.movieIndexTbl);
}
