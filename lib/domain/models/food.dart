import 'package:drift/drift.dart';
import 'meal_type.dart';

class Food extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  IntColumn get typeId =>
      integer().references(MealTypes, #id, onDelete: KeyAction.cascade)();

  TextColumn get imageUrl => text().nullable()();
}
