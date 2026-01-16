import 'package:equatable/equatable.dart';
import 'package:my_flutter_app/application/entities/food_model_item.dart';
import 'package:my_flutter_app/application/entities/type_model.dart';

abstract class RandomState extends Equatable {}

class RandomInitialState extends RandomState {
  @override
  List<Object?> get props => [];
}

class RandomLoadingState extends RandomState {
  @override
  List<Object?> get props => [];
}

class RandomErrorState extends RandomState {
  final String errorMessage;

  RandomErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class RandomLoadedState extends RandomState {
  final List<FoodModelItem> foods;
  final List<TypeModel> types;
  final int? selectedTypeId;

  RandomLoadedState({
    this.foods = const [],
    this.types = const [],
    this.selectedTypeId,
  });

  @override
  List<Object?> get props => [foods, types, selectedTypeId];
}

class RandomRollingState extends RandomState {
  final List<FoodModelItem> foods;
  final List<TypeModel> types;
  final int? selectedTypeId;

  RandomRollingState({
    required this.foods,
    required this.types,
    this.selectedTypeId,
  });

  @override
  List<Object?> get props => [foods, types, selectedTypeId];
}

class RandomRolledState extends RandomState {
  final List<FoodModelItem> foods;
  final List<TypeModel> types;
  final FoodModelItem randomFoodItem;
  final int? selectedTypeId;

  RandomRolledState({
    required this.foods,
    required this.types,
    required this.randomFoodItem,
    this.selectedTypeId,
  });

  @override
  List<Object?> get props => [foods, types, randomFoodItem, selectedTypeId];
}
