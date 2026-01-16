import 'package:drift/drift.dart';

class MealTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
