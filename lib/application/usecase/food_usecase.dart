import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/application/repositories/interface_food_repository.dart';
import '../entities/food_details_model.dart';
import '../entities/food_model_item.dart';

class FoodUsecase {
  final InterfaceFoodRepository foodRepository;

  FoodUsecase({required this.foodRepository});

  Future<List<FoodModelItem>> fetchAllFoodItems(
    int? typeId,
    String? keyword,
  ) async {
    // Addition business logic
    return await foodRepository.fetchAllFoodItems(typeId, keyword);
  }

  Future<FoodDetailsModel?> fetchFoodItemById(int id) async {
    // Addition business logic
    return await foodRepository.fetchFoodItemById(id);
  }

  Future<FoodModelItem> addFoodItem(
    String? name,
    int? typeId,
    XFile? itemImageFile,
  ) async {
    try {
      // Upload image here
      String? uploadedFileUrl = '';

      return await foodRepository.addFoodItem(name, typeId, uploadedFileUrl);
    } catch (e) {
      throw Exception('Failed to add food item: $e');
    }
  }

  Future<FoodModelItem> updateFoodItem(
    int? id,
    String? name,
    int? typeId,
    XFile? itemImageFile,
  ) async {
    try {
      String? uploadedFileUrl = '';

      return await foodRepository.updateFoodItem(
        id,
        name,
        typeId,
        uploadedFileUrl,
      );
    } catch (e) {
      throw Exception('Failed to update food item: $e');
    }
  }

  Future<void> deleteFoodItem(int id) async {
    try {
      await foodRepository.deleteFoodItem(id);
    } catch (e) {
      throw Exception('Failed to delete food item: $e');
    }
  }

  Future<List<FoodModelItem>> searchFoodItemByName(String name) async {
    try {
      return await foodRepository.searchFoodItemByName(name);
    } catch (e) {
      throw Exception('Failed to search food item: $e');
    }
  }

  Future<FoodModelItem?> getRandomFoodItem(int? typeId) async {
    try {
      return await foodRepository.getRandomFoodItem(typeId);
    } catch (e) {
      throw Exception('Failed to get random food item: $e');
    }
  }
}
