import 'package:my_flutter_app/application/entities/food_details_model.dart';
import 'package:my_flutter_app/application/entities/food_model_item.dart';

abstract class InterfaceFoodRepository {
  Future<List<FoodModelItem>> fetchAllFoodItems(int? typeId, String? keyword);
  Future<FoodDetailsModel?> fetchFoodItemById(int id);
  Future<FoodModelItem> addFoodItem(
    String? name,
    int? typeId,
    String? imageUrl,
  );
  Future<FoodModelItem> updateFoodItem(
    int? id,
    String? name,
    int? typeId,
    String? imageUrl,
  );
  Future<void> deleteFoodItem(int id);
  Future<List<FoodModelItem>> searchFoodItemByName(String name);
  Future<FoodModelItem?> getRandomFoodItem(int? typeId);
}
