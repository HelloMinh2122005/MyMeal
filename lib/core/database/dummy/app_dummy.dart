import 'package:drift/drift.dart';
import 'package:my_flutter_app/core/database/app_database.dart';

class AppDummy {
  final AppDatabase database;

  AppDummy(this.database);

  /// Seed dummy data into the database
  Future<void> seedData() async {
    // Insert meal types first
    await _insertMealTypes();

    // Then insert foods
    await _insertFoods();
  }

  /// Insert meal types into database
  Future<void> _insertMealTypes() async {
    final mealTypes = [
      MealTypesCompanion.insert(id: const Value(1), name: '🌅 Sáng'),
      MealTypesCompanion.insert(id: const Value(2), name: '☀️ Trưa'),
      MealTypesCompanion.insert(id: const Value(3), name: '🌤️ Chiều'),
      MealTypesCompanion.insert(id: const Value(4), name: '🌙 Tối'),
      MealTypesCompanion.insert(id: const Value(5), name: '🍟 Ăn vặt'),
    ];

    for (var mealType in mealTypes) {
      await database
          .into(database.mealTypes)
          .insert(mealType, mode: InsertMode.insertOrReplace);
    }
  }

  /// Insert foods into database
  Future<void> _insertFoods() async {
    final foods = [
      FoodCompanion.insert(
        id: const Value(1),
        name: 'Phở bò',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(2),
        name: 'Phở gà',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(3),
        name: 'Bún bò Huế',
        typeId: 2,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(4),
        name: 'Bún chả Hà Nội',
        typeId: 2,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(5),
        name: 'Cơm tấm sườn',
        typeId: 2,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(6),
        name: 'Cơm gà Hội An',
        typeId: 2,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(7),
        name: 'Bánh mì thịt nướng',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(8),
        name: 'Bánh mì pate',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(9),
        name: 'Bún riêu cua',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(10),
        name: 'Bún đậu mắm tôm',
        typeId: 4,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(11),
        name: 'Mì Quảng',
        typeId: 2,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(12),
        name: 'Xôi xéo',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(13),
        name: 'Xôi gà',
        typeId: 1,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(14),
        name: 'Chè bưởi',
        typeId: 3,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(15),
        name: 'Chè thái',
        typeId: 3,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(16),
        name: 'Nem rán Hà Nội',
        typeId: 4,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(17),
        name: 'Nem nướng Nha Trang',
        typeId: 4,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(18),
        name: 'Cơm rang dưa bò',
        typeId: 4,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(19),
        name: 'Phở cuốn',
        typeId: 3,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(20),
        name: 'Bún thịt nướng',
        typeId: 2,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
      FoodCompanion.insert(
        id: const Value(21),
        name: 'Bánh tráng trộn',
        typeId: 5,
        imageUrl: const Value('assets/user_data/dummy_food_img.jpg'),
      ),
    ];

    for (var food in foods) {
      await database
          .into(database.food)
          .insert(food, mode: InsertMode.insertOrReplace);
    }
  }

  /// Clear all data from database
  Future<void> clearData() async {
    await database.delete(database.food).go();
    await database.delete(database.mealTypes).go();
  }

  /// Check if database has data
  Future<bool> hasData() async {
    final foodCount = await database.select(database.food).get();
    final typesCount = await database.select(database.mealTypes).get();
    return foodCount.isNotEmpty && typesCount.isNotEmpty;
  }
}
