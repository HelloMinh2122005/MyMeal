import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/food_model_item.dart';

class FoodUsecase {
  Future<List<FoodModelItem>> fetchAllFoodItems(int? typeId) async {
    List<FoodModelItem> foodItems = [];
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    foodItems = (data['foods'] as List)
        .where((item) {
          if (typeId != null) {
            return item['meal_type_id'] == typeId;
          }
          return true;
        })
        .map((item) => FoodModelItem.fromJson(item))
        .toList();

    return foodItems;
  }

  Future<FoodModelItem> fetchFoodItemById(int id) async {
    FoodModelItem foodItem;
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    final item = (data['foods'] as List).firstWhere(
      (item) => item['id'] == id,
      orElse: () => null,
    );
    if (item != null) {
      foodItem = FoodModelItem.fromJson(item);
    } else {
      throw Exception('Food item not found');
    }
    return foodItem;
  }

  Future<FoodModelItem> addFoodItem() async {
    try {
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

  Future<FoodModelItem> updateFoodItem() async {
    try {
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

  Future<FoodModelItem> getRandomFoodItem(int? typeId) async {
    List<FoodModelItem> foodItems = [];
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    foodItems = (data['foods'] as List)
        .where(
          typeId != null ? (item) => item['typeId'] == typeId : (item) => true,
        )
        .map((item) => FoodModelItem.fromJson(item))
        .toList();
    foodItems.shuffle();
    return foodItems.first;
  }
}
