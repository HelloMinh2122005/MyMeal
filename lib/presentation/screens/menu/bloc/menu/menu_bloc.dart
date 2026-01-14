import 'package:my_flutter_app/models/food_model_item.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_event.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/usecase/food_usecase.dart';
import 'package:my_flutter_app/usecase/type_usecase.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FoodUsecase _foodUsecase;
  final TypeUsecase _typeUsecase;

  MenuBloc({required FoodUsecase foodUsecase, required TypeUsecase typeUsecase})
    : _foodUsecase = foodUsecase,
      _typeUsecase = typeUsecase,
      super(MenuState()) {
    // Register event handlers
    // on<Name of Event>(corresponding handler function)
    on<MenuLoadedStarted>(_onMenuLoadedStarted);
    on<MenuFilterChanged>(_onMenuFilterChanged);
    on<MenuDeletedFoodItem>(deleteFood);
  }

  Future<void> _onMenuLoadedStarted(
    MenuLoadedStarted event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final types = _typeUsecase.fetchAllTypes();
      final foods = _foodUsecase.fetchAllFoodItems(null, null);
      await Future.wait([types, foods]);

      emit(
        state.copyWith(
          isLoading: false,
          types: await types,
          foods: await foods,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load types: $e',
        ),
      );
    }
  }

  Future<void> _onMenuFilterChanged(
    MenuFilterChanged event,
    Emitter<MenuState> emit,
  ) async {
    String? errorMessage;
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        keyword: event.keyword,
        selectedTypeId: event.typeId,
      ),
    );
    try {
      await _foodUsecase.fetchAllFoodItems(event.typeId, event.keyword);
    } catch (e) {
      errorMessage = 'Failed to load food items: $e';
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
          foods: await _foodUsecase.fetchAllFoodItems(
            event.typeId,
            event.keyword,
          ),
        ),
      );
    }
  }

  Future<void> deleteFood(
    MenuDeletedFoodItem event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await _foodUsecase.deleteFoodItem(event.foodId);
      final foods = List<FoodModelItem>.from(state.foods);
      foods.removeWhere((food) => food.id == event.foodId);
      emit(state.copyWith(foods: foods));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete food item: $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
