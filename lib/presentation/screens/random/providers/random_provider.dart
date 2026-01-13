import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/food_model_item.dart';
import 'package:my_flutter_app/models/type_model.dart';
import 'package:my_flutter_app/usecase/food_usecase.dart';
import 'package:my_flutter_app/usecase/type_usecase.dart';

class RandomProviderNotifier extends ChangeNotifier {
  final FoodUsecase _foodUsecase;
  final TypeUsecase _typeUsecase;

  List<FoodModelItem> _foods = [];
  List<TypeModel> _types = [];
  FoodModelItem? _randomFoodItem;
  bool _isLoading = false;
  bool _isRolling = false;
  bool _isRolled = false;
  String? _errorMessage;
  int? _selectedTypeId;

  List<FoodModelItem> get foods => _foods;
  List<TypeModel> get types => _types;
  FoodModelItem? get randomFoodItem => _randomFoodItem;
  bool get isLoading => _isLoading;
  bool get isRolling => _isRolling;
  bool get isRolled => _isRolled;
  String? get errorMessage => _errorMessage;
  int? get selectedTypeId => _selectedTypeId;

  RandomProviderNotifier({
    required FoodUsecase foodUsecase,
    required TypeUsecase typeUsecase,
  }) : _foodUsecase = foodUsecase,
       _typeUsecase = typeUsecase;

  Future<void> fetchTypes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _types = await _typeUsecase.fetchAllTypes();
    } catch (e) {
      _errorMessage = 'Failed to load types: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFoods(int? typeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _foods = await _foodUsecase.fetchAllFoodItems(typeId, null);
    } catch (e) {
      _errorMessage = 'Failed to load food items: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getRandomFood(int? typeId) async {
    _isRolled = false;
    _isRolling = true;
    notifyListeners();

    if (_foods.isNotEmpty) {
      _randomFoodItem = await _foodUsecase.getRandomFoodItem(typeId);
      await Future.delayed(const Duration(seconds: 3));
      _isRolled = true;
      _isRolling = false;
      notifyListeners();
    } else {
      throw Exception('No food items available');
    }
  }

  void selectType(int? typeId) {
    _selectedTypeId = typeId;
    notifyListeners();

    fetchFoods(typeId);
  }
}
