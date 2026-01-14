import 'package:equatable/equatable.dart';
import 'package:my_flutter_app/models/food_model_item.dart';
import 'package:my_flutter_app/models/type_model.dart';

class RandomState extends Equatable {
  final List<FoodModelItem> _foods;
  final List<TypeModel> _types;
  final FoodModelItem? _randomFoodItem;
  final bool _isLoading;
  final bool _isRolling;
  final bool _isRolled;
  final String? _errorMessage;
  final int? _selectedTypeId;

  List<FoodModelItem> get foods => _foods;
  List<TypeModel> get types => _types;
  FoodModelItem? get randomFoodItem => _randomFoodItem;
  bool get isLoading => _isLoading;
  bool get isRolling => _isRolling;
  bool get isRolled => _isRolled;
  String? get errorMessage => _errorMessage;
  int? get selectedTypeId => _selectedTypeId;

  const RandomState({
    List<FoodModelItem>? foods,
    List<TypeModel>? types,
    FoodModelItem? randomFoodItem,
    bool? isLoading,
    bool? isRolling,
    bool? isRolled,
    String? errorMessage,
    int? selectedTypeId,
  }) : _foods = foods ?? const [],
       _types = types ?? const [],
       _randomFoodItem = randomFoodItem,
       _isLoading = isLoading ?? false,
       _isRolling = isRolling ?? false,
       _isRolled = isRolled ?? false,
       _errorMessage = errorMessage,
       _selectedTypeId = selectedTypeId;

  RandomState copyWith({
    List<FoodModelItem>? foods,
    List<TypeModel>? types,
    FoodModelItem? randomFoodItem,
    bool? isLoading,
    bool? isRolling,
    bool? isRolled,
    String? errorMessage,
    int? selectedTypeId,
  }) {
    return RandomState(
      foods: foods ?? _foods,
      types: types ?? _types,
      randomFoodItem: randomFoodItem ?? _randomFoodItem,
      isLoading: isLoading ?? _isLoading,
      isRolling: isRolling ?? _isRolling,
      isRolled: isRolled ?? _isRolled,
      errorMessage: errorMessage ?? _errorMessage,
      selectedTypeId: selectedTypeId ?? _selectedTypeId,
    );
  }

  @override
  List<Object?> get props => [
    _foods,
    _types,
    _randomFoodItem,
    _isLoading,
    _isRolling,
    _isRolled,
    _errorMessage,
    _selectedTypeId,
  ];
}
