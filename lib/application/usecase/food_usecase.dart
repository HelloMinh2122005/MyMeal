import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../entities/food_details_model.dart';
import '../entities/food_model_item.dart';

class FoodUsecase {
  Future<List<FoodModelItem>> fetchAllFoodItems(
    int? typeId,
    String? keyword,
  ) async {
    List<FoodModelItem> foodItems = [];
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    foodItems = (data['foods'] as List)
        .where((item) {
          final matchesType = typeId == null || item['meal_type_id'] == typeId;
          final matchesKeyword =
              keyword == null ||
              keyword.isEmpty ||
              item['name'].toString().toLowerCase().contains(
                keyword.toLowerCase(),
              );
          return matchesType && matchesKeyword;
        })
        .map((item) => FoodModelItem.fromJson(item))
        .toList();

    return foodItems;
  }

  Future<FoodDetailsModel?> fetchFoodItemById(int id) async {
    FoodDetailsModel foodItem;
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    final item = (data['foods'] as List).firstWhere(
      (item) => item['id'] == id,
      orElse: () => null,
    );
    if (item != null) {
      foodItem = FoodDetailsModel.fromJson(item);
    } else {
      return null;
    }
    return foodItem;
  }

  Future<FoodModelItem> addFoodItem(
    String? name,
    int? typeId,
    XFile? itemImageFile,
  ) async {
    try {
      // Upload image here

      return FoodModelItem(
        id: 1,
        name: 'New Food',
        typeName: 'New Type',
        imageUrl: '',
      );
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
      // Upload image here

      return FoodModelItem(
        id: 1,
        name: 'Updated Food',
        typeName: 'Updated Type',
        imageUrl: '',
      );
    } catch (e) {
      throw Exception('Failed to update food item: $e');
    }
  }

  Future<void> deleteFoodItem(int id) async {
    try {
      return;
    } catch (e) {
      throw Exception('Failed to delete food item: $e');
    }
  }

  Future<List<FoodModelItem>> searchFoodItemByName(String name) async {
    try {
      final String response = await rootBundle.loadString(
        'assets/mock_data.json',
      );
      final data = json.decode(response);
      final item = (data['foods'] as List)
          .where(
            (item) =>
                item['name'].toString().toLowerCase() == name.toLowerCase(),
          )
          .toList();
      return item.map((item) => FoodModelItem.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to search food item: $e');
    }
  }

  Future<FoodModelItem?> getRandomFoodItem(int? typeId) async {
    List<FoodModelItem> foodItems = [];
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    foodItems = (data['foods'] as List)
        .where(
          typeId != null
              ? (item) => item['meal_type_id'] == typeId
              : (item) => true,
        )
        .map((item) => FoodModelItem.fromJson(item))
        .toList();
    if (foodItems.isEmpty) {
      return null;
    }
    foodItems.shuffle();
    return foodItems.first;
  }
}
