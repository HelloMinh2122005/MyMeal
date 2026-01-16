// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MealTypesTable extends MealTypes
    with TableInfo<$MealTypesTable, MealType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $MealTypesTable createAlias(String alias) {
    return $MealTypesTable(attachedDatabase, alias);
  }
}

class MealType extends DataClass implements Insertable<MealType> {
  final int id;
  final String name;
  const MealType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  MealTypesCompanion toCompanion(bool nullToAbsent) {
    return MealTypesCompanion(id: Value(id), name: Value(name));
  }

  factory MealType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  MealType copyWith({int? id, String? name}) =>
      MealType(id: id ?? this.id, name: name ?? this.name);
  MealType copyWithCompanion(MealTypesCompanion data) {
    return MealType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealType(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealType && other.id == this.id && other.name == this.name);
}

class MealTypesCompanion extends UpdateCompanion<MealType> {
  final Value<int> id;
  final Value<String> name;
  const MealTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MealTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<MealType> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  MealTypesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return MealTypesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FoodTable extends Food with TableInfo<$FoodTable, FoodData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, typeId, imageUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
    );
  }

  @override
  $FoodTable createAlias(String alias) {
    return $FoodTable(attachedDatabase, alias);
  }
}

class FoodData extends DataClass implements Insertable<FoodData> {
  final int id;
  final String name;
  final int typeId;
  final String? imageUrl;
  const FoodData({
    required this.id,
    required this.name,
    required this.typeId,
    this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type_id'] = Variable<int>(typeId);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    return map;
  }

  FoodCompanion toCompanion(bool nullToAbsent) {
    return FoodCompanion(
      id: Value(id),
      name: Value(name),
      typeId: Value(typeId),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
    );
  }

  factory FoodData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      typeId: serializer.fromJson<int>(json['typeId']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'typeId': serializer.toJson<int>(typeId),
      'imageUrl': serializer.toJson<String?>(imageUrl),
    };
  }

  FoodData copyWith({
    int? id,
    String? name,
    int? typeId,
    Value<String?> imageUrl = const Value.absent(),
  }) => FoodData(
    id: id ?? this.id,
    name: name ?? this.name,
    typeId: typeId ?? this.typeId,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
  );
  FoodData copyWithCompanion(FoodCompanion data) {
    return FoodData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('typeId: $typeId, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, typeId, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodData &&
          other.id == this.id &&
          other.name == this.name &&
          other.typeId == this.typeId &&
          other.imageUrl == this.imageUrl);
}

class FoodCompanion extends UpdateCompanion<FoodData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> typeId;
  final Value<String?> imageUrl;
  const FoodCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.typeId = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  FoodCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int typeId,
    this.imageUrl = const Value.absent(),
  }) : name = Value(name),
       typeId = Value(typeId);
  static Insertable<FoodData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? typeId,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (typeId != null) 'type_id': typeId,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  FoodCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? typeId,
    Value<String?>? imageUrl,
  }) {
    return FoodCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      typeId: typeId ?? this.typeId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('typeId: $typeId, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MealTypesTable mealTypes = $MealTypesTable(this);
  late final $FoodTable food = $FoodTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mealTypes, food];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('food', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MealTypesTableCreateCompanionBuilder =
    MealTypesCompanion Function({Value<int> id, required String name});
typedef $$MealTypesTableUpdateCompanionBuilder =
    MealTypesCompanion Function({Value<int> id, Value<String> name});

final class $$MealTypesTableReferences
    extends BaseReferences<_$AppDatabase, $MealTypesTable, MealType> {
  $$MealTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FoodTable, List<FoodData>> _foodRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.food,
    aliasName: $_aliasNameGenerator(db.mealTypes.id, db.food.typeId),
  );

  $$FoodTableProcessedTableManager get foodRefs {
    final manager = $$FoodTableTableManager(
      $_db,
      $_db.food,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_foodRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealTypesTableFilterComposer
    extends Composer<_$AppDatabase, $MealTypesTable> {
  $$MealTypesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> foodRefs(
    Expression<bool> Function($$FoodTableFilterComposer f) f,
  ) {
    final $$FoodTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableFilterComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $MealTypesTable> {
  $$MealTypesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealTypesTable> {
  $$MealTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> foodRefs<T extends Object>(
    Expression<T> Function($$FoodTableAnnotationComposer a) f,
  ) {
    final $$FoodTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableAnnotationComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealTypesTable,
          MealType,
          $$MealTypesTableFilterComposer,
          $$MealTypesTableOrderingComposer,
          $$MealTypesTableAnnotationComposer,
          $$MealTypesTableCreateCompanionBuilder,
          $$MealTypesTableUpdateCompanionBuilder,
          (MealType, $$MealTypesTableReferences),
          MealType,
          PrefetchHooks Function({bool foodRefs})
        > {
  $$MealTypesTableTableManager(_$AppDatabase db, $MealTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => MealTypesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  MealTypesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (foodRefs) db.food],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (foodRefs)
                    await $_getPrefetchedData<
                      MealType,
                      $MealTypesTable,
                      FoodData
                    >(
                      currentTable: table,
                      referencedTable: $$MealTypesTableReferences
                          ._foodRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MealTypesTableReferences(db, table, p0).foodRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.typeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealTypesTable,
      MealType,
      $$MealTypesTableFilterComposer,
      $$MealTypesTableOrderingComposer,
      $$MealTypesTableAnnotationComposer,
      $$MealTypesTableCreateCompanionBuilder,
      $$MealTypesTableUpdateCompanionBuilder,
      (MealType, $$MealTypesTableReferences),
      MealType,
      PrefetchHooks Function({bool foodRefs})
    >;
typedef $$FoodTableCreateCompanionBuilder =
    FoodCompanion Function({
      Value<int> id,
      required String name,
      required int typeId,
      Value<String?> imageUrl,
    });
typedef $$FoodTableUpdateCompanionBuilder =
    FoodCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> typeId,
      Value<String?> imageUrl,
    });

final class $$FoodTableReferences
    extends BaseReferences<_$AppDatabase, $FoodTable, FoodData> {
  $$FoodTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MealTypesTable _typeIdTable(_$AppDatabase db) => db.mealTypes
      .createAlias($_aliasNameGenerator(db.food.typeId, db.mealTypes.id));

  $$MealTypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$MealTypesTableTableManager(
      $_db,
      $_db.mealTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FoodTableFilterComposer extends Composer<_$AppDatabase, $FoodTable> {
  $$FoodTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$MealTypesTableFilterComposer get typeId {
    final $$MealTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.mealTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTypesTableFilterComposer(
            $db: $db,
            $table: $db.mealTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodTableOrderingComposer extends Composer<_$AppDatabase, $FoodTable> {
  $$FoodTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealTypesTableOrderingComposer get typeId {
    final $$MealTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.mealTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTypesTableOrderingComposer(
            $db: $db,
            $table: $db.mealTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodTable> {
  $$FoodTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  $$MealTypesTableAnnotationComposer get typeId {
    final $$MealTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.mealTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.mealTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodTable,
          FoodData,
          $$FoodTableFilterComposer,
          $$FoodTableOrderingComposer,
          $$FoodTableAnnotationComposer,
          $$FoodTableCreateCompanionBuilder,
          $$FoodTableUpdateCompanionBuilder,
          (FoodData, $$FoodTableReferences),
          FoodData,
          PrefetchHooks Function({bool typeId})
        > {
  $$FoodTableTableManager(_$AppDatabase db, $FoodTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
              }) => FoodCompanion(
                id: id,
                name: name,
                typeId: typeId,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int typeId,
                Value<String?> imageUrl = const Value.absent(),
              }) => FoodCompanion.insert(
                id: id,
                name: name,
                typeId: typeId,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FoodTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (typeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.typeId,
                                referencedTable: $$FoodTableReferences
                                    ._typeIdTable(db),
                                referencedColumn: $$FoodTableReferences
                                    ._typeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FoodTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodTable,
      FoodData,
      $$FoodTableFilterComposer,
      $$FoodTableOrderingComposer,
      $$FoodTableAnnotationComposer,
      $$FoodTableCreateCompanionBuilder,
      $$FoodTableUpdateCompanionBuilder,
      (FoodData, $$FoodTableReferences),
      FoodData,
      PrefetchHooks Function({bool typeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MealTypesTableTableManager get mealTypes =>
      $$MealTypesTableTableManager(_db, _db.mealTypes);
  $$FoodTableTableManager get food => $$FoodTableTableManager(_db, _db.food);
}
