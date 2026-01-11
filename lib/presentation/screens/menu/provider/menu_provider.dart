import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/food_details_model.dart';
import 'package:my_flutter_app/models/type_model.dart';
import '../../../../models/food_model_item.dart';
import '../../../../usecase/food_usecase.dart';
import '../../../../usecase/type_usecase.dart';

class MenuProvider extends ChangeNotifier {
  final FoodUsecase _foodUsecase;
  final TypeUsecase _typeUsecase;

  // State of food items
  List<FoodModelItem> _foods = [];
  List<TypeModel> _types = [];
  bool _isLoading = false;
  String? _errorMessage;
  int? _selectedTypeId;
  String? _keyword;

  // Getter for UI
  List<FoodModelItem> get foods => _foods;
  List<TypeModel> get types => _types;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get selectedTypeId => _selectedTypeId;
  String? get keyword => _keyword;

  // Inject usecase to provider
  MenuProvider({
    required FoodUsecase foodUsecase,
    required TypeUsecase typeUsecase,
  }) : _foodUsecase = foodUsecase,
       _typeUsecase = typeUsecase;

  Future<void> fetchTypes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // stimulate network delay
      await Future.delayed(const Duration(seconds: 1));
      _types = await _typeUsecase.fetchAllTypes();
    } catch (e) {
      _errorMessage = 'Failed to load types: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<FoodDetailsModel?> fetchFoodItemById(int id) async {
    try {
      return await _foodUsecase.fetchFoodItemById(id);
    } catch (e) {
      _errorMessage = 'Failed to get food item: $e';
      notifyListeners();
      return null;
    }
  }

  Future<void> fetchFoods(int? typeId, String? keyword) async {
    _isLoading = true;
    _errorMessage = null;
    _keyword = keyword;
    notifyListeners();

    try {
      _foods = await _foodUsecase.fetchAllFoodItems(typeId, keyword);
    } catch (e) {
      _errorMessage = 'Failed to load food items: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteFood(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _foodUsecase.deleteFoodItem(id);
      _foods.removeWhere((food) => food.id == id);
    } catch (e) {
      _errorMessage = 'Failed to delete food item: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<TypeModel?> getTypeById(int id) async {
    try {
      return _typeUsecase.fetchTypeById(id);
    } catch (e) {
      _errorMessage = 'Type not found: $e';
      notifyListeners();
      return null;
    }
  }

  void selectType(int? typeId, String? keyword) {
    _selectedTypeId = typeId;
    _keyword = keyword;
    notifyListeners();

    fetchFoods(typeId, keyword);
  }
}
