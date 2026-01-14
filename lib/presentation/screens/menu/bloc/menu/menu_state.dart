import 'package:my_flutter_app/models/food_model_item.dart';
import 'package:my_flutter_app/models/type_model.dart';
import 'package:equatable/equatable.dart';

class MenuState extends Equatable {
  // State of food items
  final List<FoodModelItem> foods;
  final List<TypeModel> types;
  final bool isLoading;
  final String? errorMessage;
  final int? selectedTypeId;
  final String? keyword;

  const MenuState({
    this.foods = const [],
    this.types = const [],
    this.isLoading = false,
    this.errorMessage,
    this.selectedTypeId,
    this.keyword,
  });

  MenuState copyWith({
    List<FoodModelItem>? foods,
    List<TypeModel>? types,
    bool? isLoading,
    String? errorMessage,
    int? selectedTypeId,
    String? keyword,
  }) {
    return MenuState(
      foods: foods ?? this.foods,
      types: types ?? this.types,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  List<Object?> get props => [
    foods,
    types,
    isLoading,
    errorMessage,
    selectedTypeId,
    keyword,
  ];
}
