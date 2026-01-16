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
       super(RandomInitialState()) {
    on<RandomLoadedStarted>(_onRandomLoadedStarted);
    on<RandomTypeSelected>(_onRandomTypeSelected);
    on<RandomFetchFood>(_onRandomFetchFood);
  }

  Future<void> _onRandomLoadedStarted(
    RandomLoadedStarted event,
    Emitter<RandomState> emit,
  ) async {
    emit(RandomLoadingState());

    try {
      final types = await _typeUsecase.fetchAllTypes();
      final foods = await _foodUsecase.fetchAllFoodItems(null, null);

      emit(RandomLoadedState(types: types, foods: foods));
    } catch (e) {
      emit(RandomErrorState(errorMessage: 'Failed to load data: $e'));
    }
  }

  Future<void> _onRandomTypeSelected(
    RandomTypeSelected event,
    Emitter<RandomState> emit,
  ) async {
    if (state is RandomLoadedState || state is RandomRolledState) {
      // Capture current state data BEFORE emitting loading state
      final types = state is RandomLoadedState
          ? (state as RandomLoadedState).types
          : (state as RandomRolledState).types;

      emit(RandomLoadingState());

      try {
        final foods = await _foodUsecase.fetchAllFoodItems(event.typeId, null);

        emit(
          RandomLoadedState(
            foods: foods,
            types: types,
            selectedTypeId: event.typeId,
          ),
        );
      } catch (e) {
        emit(RandomErrorState(errorMessage: 'Failed to load food items: $e'));
      }
    }
  }

  Future<void> _onRandomFetchFood(
    RandomFetchFood event,
    Emitter<RandomState> emit,
  ) async {
    if (state is RandomLoadedState || state is RandomRolledState) {
      // Capture state data before emitting rolling state
      final foods = state is RandomLoadedState
          ? (state as RandomLoadedState).foods
          : (state as RandomRolledState).foods;

      final types = state is RandomLoadedState
          ? (state as RandomLoadedState).types
          : (state as RandomRolledState).types;

      final selectedTypeId = state is RandomLoadedState
          ? (state as RandomLoadedState).selectedTypeId
          : (state as RandomRolledState).selectedTypeId;

      emit(
        RandomRollingState(
          foods: foods,
          types: types,
          selectedTypeId: selectedTypeId,
        ),
      );

      try {
        if (foods.isNotEmpty) {
          final randomFoodItem = await _foodUsecase.getRandomFoodItem(
            event.typeId,
          );
          // Simulate rolling delay
          await Future.delayed(const Duration(seconds: 3));

          emit(
            RandomRolledState(
              foods: foods,
              types: types,
              randomFoodItem: randomFoodItem!,
              selectedTypeId: selectedTypeId,
            ),
          );
        } else {
          emit(RandomErrorState(errorMessage: 'No food items available'));
        }
      } catch (e) {
        emit(
          RandomErrorState(errorMessage: 'Failed to get random food item: $e'),
        );
      }
    }
  }
}
