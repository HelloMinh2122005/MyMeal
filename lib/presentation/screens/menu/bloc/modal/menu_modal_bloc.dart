import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/models/food_details_model.dart';
import 'package:my_flutter_app/models/type_model.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_event.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_state.dart';
import 'package:my_flutter_app/usecase/food_usecase.dart';
import 'package:my_flutter_app/usecase/type_usecase.dart';

class MenuModalBloc extends Bloc<MenuModalEvent, MenuModalState> {
  final FoodUsecase _foodUsecase;
  final TypeUsecase _typeUsecase;
  final int? itemId;

  MenuModalBloc({
    required FoodUsecase foodUsecase,
    required TypeUsecase typeUsecase,
    this.itemId,
  }) : _foodUsecase = foodUsecase,
       _typeUsecase = typeUsecase,
       super(const MenuModalState()) {
    on<LoadedModalStarted>(_onLoadedModalStart);
    on<ModalSelectedMealTypeChanged>(_onMealTypeChanged);
    on<ModalImageSelected>(_onImageSelected);
    on<ConfirmSelected>(_onConfirmSelected);
  }

  Future<void> _onLoadedModalStart(
    LoadedModalStarted event,
    Emitter<MenuModalState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    List<TypeModel> types = [];
    FoodDetailsModel? foodDetails;

    try {
      types = await _typeUsecase.fetchAllTypes();
      if (itemId != null) {
        foodDetails = await _foodUsecase.fetchFoodItemById(itemId!);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
          mealTypes: types,
          itemName: foodDetails?.name ?? '',
          selectedItem: foodDetails != null
              ? types.firstWhere((type) => type.id == foodDetails?.typeId)
              : types.first,
          itemImageUrl: foodDetails?.imageUrl ?? '',
        ),
      );
    }
  }

  Future<void> _onMealTypeChanged(
    ModalSelectedMealTypeChanged event,
    Emitter<MenuModalState> emit,
  ) async {
    final selectedType = state.mealTypes.firstWhere(
      (type) => type.id == event.selectedMealTypeId,
      orElse: () => state.mealTypes.first,
    );
    emit(state.copyWith(selectedItem: selectedType));
  }

  Future<void> _onImageSelected(
    ModalImageSelected event,
    Emitter<MenuModalState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: false,
          itemImageFile: event.imageFile,
          itemImageUrl: event.imageFile != null ? '' : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          itemImageUrl: null,
          itemImageFile: null,
          errorMessage: 'Failed to select image: $e',
        ),
      );
    }
  }

  Future<void> _onConfirmSelected(
    ConfirmSelected event,
    Emitter<MenuModalState> emit,
  ) async {
    try {
      if (event.id != null) {
        await _foodUsecase.updateFoodItem(
          event.id!,
          event.name,
          event.typeId,
          event.itemImageFile,
        );
      } else {
        await _foodUsecase.addFoodItem(
          event.name,
          event.typeId,
          event.itemImageFile,
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to confirm selection: $e',
        ),
      );
    }
  }
}
