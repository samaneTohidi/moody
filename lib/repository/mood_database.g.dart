// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_database.dart';

// ignore_for_file: type=lint
class $MoodStateTable extends MoodState
    with TableInfo<$MoodStateTable, StateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sliderValueMeta =
      const VerificationMeta('sliderValue');
  @override
  late final GeneratedColumn<double> sliderValue = GeneratedColumn<double>(
      'slider_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currentColorMeta =
      const VerificationMeta('currentColor');
  @override
  late final GeneratedColumn<int> currentColor = GeneratedColumn<int>(
      'current_color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, sliderValue, currentColor, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mood_state';
  @override
  VerificationContext validateIntegrity(Insertable<StateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slider_value')) {
      context.handle(
          _sliderValueMeta,
          sliderValue.isAcceptableOrUnknown(
              data['slider_value']!, _sliderValueMeta));
    } else if (isInserting) {
      context.missing(_sliderValueMeta);
    }
    if (data.containsKey('current_color')) {
      context.handle(
          _currentColorMeta,
          currentColor.isAcceptableOrUnknown(
              data['current_color']!, _currentColorMeta));
    } else if (isInserting) {
      context.missing(_currentColorMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StateData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sliderValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}slider_value'])!,
      currentColor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_color'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $MoodStateTable createAlias(String alias) {
    return $MoodStateTable(attachedDatabase, alias);
  }
}

class StateData extends DataClass implements Insertable<StateData> {
  final int id;
  final double sliderValue;
  final int currentColor;
  final String? note;
  const StateData(
      {required this.id,
      required this.sliderValue,
      required this.currentColor,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slider_value'] = Variable<double>(sliderValue);
    map['current_color'] = Variable<int>(currentColor);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  MoodStateCompanion toCompanion(bool nullToAbsent) {
    return MoodStateCompanion(
      id: Value(id),
      sliderValue: Value(sliderValue),
      currentColor: Value(currentColor),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory StateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StateData(
      id: serializer.fromJson<int>(json['id']),
      sliderValue: serializer.fromJson<double>(json['sliderValue']),
      currentColor: serializer.fromJson<int>(json['currentColor']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sliderValue': serializer.toJson<double>(sliderValue),
      'currentColor': serializer.toJson<int>(currentColor),
      'note': serializer.toJson<String?>(note),
    };
  }

  StateData copyWith(
          {int? id,
          double? sliderValue,
          int? currentColor,
          Value<String?> note = const Value.absent()}) =>
      StateData(
        id: id ?? this.id,
        sliderValue: sliderValue ?? this.sliderValue,
        currentColor: currentColor ?? this.currentColor,
        note: note.present ? note.value : this.note,
      );
  StateData copyWithCompanion(MoodStateCompanion data) {
    return StateData(
      id: data.id.present ? data.id.value : this.id,
      sliderValue:
          data.sliderValue.present ? data.sliderValue.value : this.sliderValue,
      currentColor: data.currentColor.present
          ? data.currentColor.value
          : this.currentColor,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StateData(')
          ..write('id: $id, ')
          ..write('sliderValue: $sliderValue, ')
          ..write('currentColor: $currentColor, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sliderValue, currentColor, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StateData &&
          other.id == this.id &&
          other.sliderValue == this.sliderValue &&
          other.currentColor == this.currentColor &&
          other.note == this.note);
}

class MoodStateCompanion extends UpdateCompanion<StateData> {
  final Value<int> id;
  final Value<double> sliderValue;
  final Value<int> currentColor;
  final Value<String?> note;
  const MoodStateCompanion({
    this.id = const Value.absent(),
    this.sliderValue = const Value.absent(),
    this.currentColor = const Value.absent(),
    this.note = const Value.absent(),
  });
  MoodStateCompanion.insert({
    this.id = const Value.absent(),
    required double sliderValue,
    required int currentColor,
    this.note = const Value.absent(),
  })  : sliderValue = Value(sliderValue),
        currentColor = Value(currentColor);
  static Insertable<StateData> custom({
    Expression<int>? id,
    Expression<double>? sliderValue,
    Expression<int>? currentColor,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sliderValue != null) 'slider_value': sliderValue,
      if (currentColor != null) 'current_color': currentColor,
      if (note != null) 'note': note,
    });
  }

  MoodStateCompanion copyWith(
      {Value<int>? id,
      Value<double>? sliderValue,
      Value<int>? currentColor,
      Value<String?>? note}) {
    return MoodStateCompanion(
      id: id ?? this.id,
      sliderValue: sliderValue ?? this.sliderValue,
      currentColor: currentColor ?? this.currentColor,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sliderValue.present) {
      map['slider_value'] = Variable<double>(sliderValue.value);
    }
    if (currentColor.present) {
      map['current_color'] = Variable<int>(currentColor.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoodStateCompanion(')
          ..write('id: $id, ')
          ..write('sliderValue: $sliderValue, ')
          ..write('currentColor: $currentColor, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$MoodDatabase extends GeneratedDatabase {
  _$MoodDatabase(QueryExecutor e) : super(e);
  $MoodDatabaseManager get managers => $MoodDatabaseManager(this);
  late final $MoodStateTable moodState = $MoodStateTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moodState];
}

typedef $$MoodStateTableCreateCompanionBuilder = MoodStateCompanion Function({
  Value<int> id,
  required double sliderValue,
  required int currentColor,
  Value<String?> note,
});
typedef $$MoodStateTableUpdateCompanionBuilder = MoodStateCompanion Function({
  Value<int> id,
  Value<double> sliderValue,
  Value<int> currentColor,
  Value<String?> note,
});

class $$MoodStateTableFilterComposer
    extends Composer<_$MoodDatabase, $MoodStateTable> {
  $$MoodStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sliderValue => $composableBuilder(
      column: $table.sliderValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentColor => $composableBuilder(
      column: $table.currentColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$MoodStateTableOrderingComposer
    extends Composer<_$MoodDatabase, $MoodStateTable> {
  $$MoodStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sliderValue => $composableBuilder(
      column: $table.sliderValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentColor => $composableBuilder(
      column: $table.currentColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$MoodStateTableAnnotationComposer
    extends Composer<_$MoodDatabase, $MoodStateTable> {
  $$MoodStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get sliderValue => $composableBuilder(
      column: $table.sliderValue, builder: (column) => column);

  GeneratedColumn<int> get currentColor => $composableBuilder(
      column: $table.currentColor, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$MoodStateTableTableManager extends RootTableManager<
    _$MoodDatabase,
    $MoodStateTable,
    StateData,
    $$MoodStateTableFilterComposer,
    $$MoodStateTableOrderingComposer,
    $$MoodStateTableAnnotationComposer,
    $$MoodStateTableCreateCompanionBuilder,
    $$MoodStateTableUpdateCompanionBuilder,
    (StateData, BaseReferences<_$MoodDatabase, $MoodStateTable, StateData>),
    StateData,
    PrefetchHooks Function()> {
  $$MoodStateTableTableManager(_$MoodDatabase db, $MoodStateTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> sliderValue = const Value.absent(),
            Value<int> currentColor = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              MoodStateCompanion(
            id: id,
            sliderValue: sliderValue,
            currentColor: currentColor,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double sliderValue,
            required int currentColor,
            Value<String?> note = const Value.absent(),
          }) =>
              MoodStateCompanion.insert(
            id: id,
            sliderValue: sliderValue,
            currentColor: currentColor,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MoodStateTableProcessedTableManager = ProcessedTableManager<
    _$MoodDatabase,
    $MoodStateTable,
    StateData,
    $$MoodStateTableFilterComposer,
    $$MoodStateTableOrderingComposer,
    $$MoodStateTableAnnotationComposer,
    $$MoodStateTableCreateCompanionBuilder,
    $$MoodStateTableUpdateCompanionBuilder,
    (StateData, BaseReferences<_$MoodDatabase, $MoodStateTable, StateData>),
    StateData,
    PrefetchHooks Function()>;

class $MoodDatabaseManager {
  final _$MoodDatabase _db;
  $MoodDatabaseManager(this._db);
  $$MoodStateTableTableManager get moodState =>
      $$MoodStateTableTableManager(_db, _db.moodState);
}
