import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


part 'mood_database.g.dart';

@DataClassName('StateData')
class MoodState extends Table{
  IntColumn get id => integer().autoIncrement()();
  RealColumn get sliderValue => real()();
  IntColumn get currentColor => integer()();
  TextColumn get note => text().nullable()();
}

@DriftDatabase(tables: [MoodState])
class MoodDatabase extends _$MoodDatabase{
  MoodDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertState(double sliderValue, int currentColor, String text) {
    return into(moodState).insert(MoodStateCompanion(
      sliderValue: Value(sliderValue),
      currentColor: Value(currentColor),
      note: Value(text),
    ));
  }

  Future<StateData?> fetchLatestState() {
    return (select(moodState)..orderBy([(t) => OrderingTerm.desc(t.id)])).getSingleOrNull();
  }

  Future<List<StateData>> fetchAllStates() {
    return select(moodState).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mood_database.sqlite'));
    return NativeDatabase(file);
  });
}
