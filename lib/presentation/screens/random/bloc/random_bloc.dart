import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/presentation/screens/random/bloc/random_event.dart';
import 'package:my_flutter_app/presentation/screens/random/bloc/random_state.dart';
import 'package:my_flutter_app/application/usecase/food_usecase.dart';
import 'package:my_flutter_app/application/usecase/type_usecase.dart';

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final FoodUsecase _foodUsecase;
  final TypeUsecase _typeUsecase;

  RandomBloc({
    required FoodUsecase foodUsecase,
    required TypeUsecase typeUsecase,
  }) : _foodUsecase = foodUsecase,
       _typeUsecase = typeUsecase,
       super(const RandomState()) {
    on<RandomLoadedStarted>(_onRandomLoadedStarted);
    on<RandomTypeSelected>(_onRandomTypeSelected);
    on<RandomFetchFood>(_onRandomFetchFood);
  }

  Future<void> _onRandomLoadedStarted(
    RandomLoadedStarted event,
    Emitter<RandomState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final types = _typeUsecase.fetchAllTypes();
      final foods = _foodUsecase.fetchAllFoodItems(null, null);
      Future.wait([types, foods]);
      emit(
        state.copyWith(
          types: await types,
          foods: await foods,
          isLoading: false,
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

  Future<void> _onRandomTypeSelected(
    RandomTypeSelected event,
    Emitter<RandomState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final foods = await _foodUsecase.fetchAllFoodItems(event.typeId, null);
      emit(
        state.copyWith(
          foods: foods,
          selectedTypeId: event.typeId,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load food items: $e',
        ),
      );
    }
  }

  Future<void> _onRandomFetchFood(
    RandomFetchFood event,
    Emitter<RandomState> emit,
  ) async {
    emit(state.copyWith(isRolling: true, isRolled: false, errorMessage: null));

    try {
      if (state.foods.isNotEmpty) {
        final randomFoodItem = await _foodUsecase.getRandomFoodItem(
          event.typeId,
        );
        // Simulate rolling delay
        await Future.delayed(const Duration(seconds: 3));
        emit(
          state.copyWith(
            randomFoodItem: randomFoodItem,
            isRolling: false,
            isRolled: true,
          ),
        );
      } else {
        throw Exception('No food items available');
      }
    } catch (e) {
      emit(
        state.copyWith(
          isRolling: false,
          errorMessage: 'Failed to get random food item: $e',
        ),
      );
    }
  }
}
