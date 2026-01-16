import 'dart:math';

import 'package:drift/drift.dart';
import 'package:my_flutter_app/application/entities/food_details_model.dart';
import 'package:my_flutter_app/application/entities/food_model_item.dart';
import 'package:my_flutter_app/application/repositories/interface_food_repository.dart';
import 'package:my_flutter_app/core/database/app_database.dart';

class FoodRepository implements InterfaceFoodRepository {
  final AppDatabase database;

  FoodRepository(this.database);

  @override
  Future<List<FoodModelItem>> fetchAllFoodItems(
    int? typeId,
    String? keyword,
  ) async {
    try {
      final query = database.select(database.food).join([
        leftOuterJoin(
          database.mealTypes,
          database.mealTypes.id.equalsExp(database.food.typeId),
        ),
      ]);

      if (typeId != null) {
        query.where(database.food.typeId.equals(typeId));
      }

      if (keyword != null && keyword.isNotEmpty) {
        query.where(
          database.food.name.lower().like('%${keyword.toLowerCase()}%'),
        );
      }

      final results = await query.get();

      return results.map((row) {
        final food = row.readTable(database.food);
        final mealType = row.readTableOrNull(database.mealTypes);

        return FoodModelItem(
          id: food.id,
          name: food.name,
          typeName: mealType?.name ?? '',
          imageUrl: food.imageUrl ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch food items: $e');
    }
  }

  @override
  Future<FoodDetailsModel?> fetchFoodItemById(int id) async {
    try {
      final query = database.select(database.food).join([
        leftOuterJoin(
          database.mealTypes,
          database.mealTypes.id.equalsExp(database.food.typeId),
        ),
      ])..where(database.food.id.equals(id));

      final result = await query.getSingleOrNull();

      if (result == null) {
        return null;
      }

      final food = result.readTable(database.food);
      final mealType = result.readTableOrNull(database.mealTypes);

      return FoodDetailsModel(
        id: food.id,
        name: food.name,
        imageUrl: food.imageUrl ?? '',
        typeId: food.typeId,
        typeName: mealType?.name ?? '',
      );
    } catch (e) {
      throw Exception('Failed to fetch food item: $e');
    }
  }

  @override
  Future<FoodModelItem> addFoodItem(
    String? name,
    int? typeId,
    String? imageUrl,
  ) async {
    try {
      if (name == null || typeId == null) {
        throw Exception('Name and type ID are required');
      }

      final id = await database
          .into(database.food)
          .insert(
            FoodCompanion.insert(
              name: name,
              typeId: typeId,
              imageUrl: Value(imageUrl),
            ),
          );

      final mealType = await (database.select(
        database.mealTypes,
      )..where((t) => t.id.equals(typeId))).getSingle();

      return FoodModelItem(
        id: id,
        name: name,
        typeName: mealType.name,
        imageUrl: imageUrl ?? '',
      );
    } catch (e) {
      throw Exception('Failed to add food item: $e');
    }
  }

  @override
  Future<FoodModelItem> updateFoodItem(
    int? id,
    String? name,
    int? typeId,
    String? imageUrl,
  ) async {
    try {
      if (id == null || name == null || typeId == null) {
        throw Exception('ID, name, and type ID are required');
      }

      await (database.update(
        database.food,
      )..where((t) => t.id.equals(id))).write(
        FoodCompanion(
          name: Value(name),
          typeId: Value(typeId),
          imageUrl: Value(imageUrl),
        ),
      );

      final mealType = await (database.select(
        database.mealTypes,
      )..where((t) => t.id.equals(typeId))).getSingle();

      return FoodModelItem(
        id: id,
        name: name,
        typeName: mealType.name,
        imageUrl: imageUrl ?? '',
      );
    } catch (e) {
      throw Exception('Failed to update food item: $e');
    }
  }

  @override
  Future<void> deleteFoodItem(int id) async {
    try {
      await (database.delete(
        database.food,
      )..where((t) => t.id.equals(id))).go();
    } catch (e) {
      throw Exception('Failed to delete food item: $e');
    }
  }

  @override
  Future<List<FoodModelItem>> searchFoodItemByName(String name) async {
    try {
      final query = database.select(database.food).join([
        leftOuterJoin(
          database.mealTypes,
          database.mealTypes.id.equalsExp(database.food.typeId),
        ),
      ])..where(database.food.name.lower().equals(name.toLowerCase()));

      final results = await query.get();

      return results.map((row) {
        final food = row.readTable(database.food);
        final mealType = row.readTableOrNull(database.mealTypes);

        return FoodModelItem(
          id: food.id,
          name: food.name,
          typeName: mealType?.name ?? '',
          imageUrl: food.imageUrl ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to search food item: $e');
    }
  }

  @override
  Future<FoodModelItem?> getRandomFoodItem(int? typeId) async {
    try {
      final query = database.select(database.food).join([
        leftOuterJoin(
          database.mealTypes,
          database.mealTypes.id.equalsExp(database.food.typeId),
        ),
      ]);

      if (typeId != null) {
        query.where(database.food.typeId.equals(typeId));
      }

      final results = await query.get();

      if (results.isEmpty) {
        return null;
      }

      final random = Random();
      final randomResult = results[random.nextInt(results.length)];

      final food = randomResult.readTable(database.food);
      final mealType = randomResult.readTableOrNull(database.mealTypes);

      return FoodModelItem(
        id: food.id,
        name: food.name,
        typeName: mealType?.name ?? '',
        imageUrl: food.imageUrl ?? '',
      );
    } catch (e) {
      throw Exception('Failed to get random food item: $e');
    }
  }
}
