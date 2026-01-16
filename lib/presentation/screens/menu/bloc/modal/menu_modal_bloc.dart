import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/application/entities/food_details_model.dart';
import 'package:my_flutter_app/application/entities/type_model.dart';
import 'package:my_flutter_app/core/services/media_service.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_event.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_state.dart';
import 'package:my_flutter_app/application/usecase/food_usecase.dart';
import 'package:my_flutter_app/application/usecase/type_usecase.dart';

class MenuModalBloc extends Bloc<MenuModalEvent, MenuModalState> {
  final FoodUsecase _foodUsecase;
  final TypeUsecase _typeUsecase;
  final MediaService _mediaService;
  final int? itemId;

  MenuModalBloc({
    required FoodUsecase foodUsecase,
    required TypeUsecase typeUsecase,
    required MediaService mediaService,
    this.itemId,
  }) : _foodUsecase = foodUsecase,
       _typeUsecase = typeUsecase,
       _mediaService = mediaService,
       super(MenuModalInitialState()) {
    on<LoadedModalStartedEvent>(_onLoadedModalStart);
    on<ModalSelectedMealTypeChangedEvent>(_onMealTypeChanged);
    on<ModalImageSelectedEvent>(_onImageSelected);
    on<ConfirmSelectedEvent>(_onConfirmSelected);
    on<ImageRemovedEvent>(_onImageRemoved);
    on<ModalItemNameChangedEvent>(_onModalItemNameChanged);
  }

  Future<void> _onLoadedModalStart(
    LoadedModalStartedEvent event,
    Emitter<MenuModalState> emit,
  ) async {
    emit(MenuModalLoadingState());

    List<TypeModel> types = [];
    FoodDetailsModel? foodDetails;

    try {
      types = await _typeUsecase.fetchAllTypes();
      if (itemId != null) {
        foodDetails = await _foodUsecase.fetchFoodItemById(itemId!);
      }

      // If editing existing item, use its type; otherwise use first type as default
      final selectedType = foodDetails != null
          ? types.firstWhere(
              (type) => type.id == foodDetails!.typeId,
              orElse: () => types.first,
            )
          : types.first;

      emit(
        MenuModalLoadedState(
          mealTypes: types,
          itemName: foodDetails?.name ?? '',
          selectedItem: selectedType,
          itemImageFile: null, // SHOULD ALWAYS BE NULL
          itemImageUrl: foodDetails?.imageUrl,
        ),
      );
    } catch (e) {
      emit(MenuModalErrorState(errorMessage: 'Failed to load data: $e'));
    }
  }

  Future<void> _onMealTypeChanged(
    ModalSelectedMealTypeChangedEvent event,
    Emitter<MenuModalState> emit,
  ) async {
    if (state is MenuModalLoadedState) {
      final currentState = state as MenuModalLoadedState;
      final selectedType = currentState.mealTypes.firstWhere(
        (type) => type.id == event.selectedMealTypeId,
        orElse: () => currentState.mealTypes.first,
      );
      emit(
        MenuModalLoadedState(
          mealTypes: currentState.mealTypes,
          itemName: currentState.itemName,
          selectedItem: selectedType,
          itemImageFile: currentState.itemImageFile,
          itemImageUrl: currentState.itemImageUrl,
        ),
      );
    }
  }

  Future<void> _onImageSelected(
    ModalImageSelectedEvent event,
    Emitter<MenuModalState> emit,
  ) async {
    try {
      if (state is MenuModalLoadedState) {
        final currentState = state as MenuModalLoadedState;

        final XFile? newImageSelected = await _mediaService
            .captureImageWithCamera();

        emit(
          MenuModalLoadedState(
            mealTypes: currentState.mealTypes,
            itemName: currentState.itemName,
            selectedItem: currentState.selectedItem,
            itemImageFile: newImageSelected,
          ),
        );
      }
    } catch (e) {
      emit(MenuModalErrorState(errorMessage: 'Failed to select image: $e'));
    }
  }

  Future<void> _onImageRemoved(
    ImageRemovedEvent event,
    Emitter<MenuModalState> emit,
  ) async {
    try {
      if (state is MenuModalLoadedState) {
        final currentState = state as MenuModalLoadedState;

        emit(
          MenuModalLoadedState(
            mealTypes: currentState.mealTypes,
            itemName: currentState.itemName,
            selectedItem: currentState.selectedItem,
            itemImageFile: null,
            itemImageUrl: null,
          ),
        );
      }
    } catch (e) {
      emit(MenuModalErrorState(errorMessage: 'Failed to remove image: $e'));
    }
  }

  Future<void> _onConfirmSelected(
    ConfirmSelectedEvent event,
    Emitter<MenuModalState> emit,
  ) async {
    try {
      emit(MenuModalLoadingState());

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

      // Show the success state
      emit(MenuSucessState());

      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      emit(
        MenuModalErrorState(errorMessage: 'Failed to confirm selection: $e'),
      );
    }
  }

  Future<void> _onModalItemNameChanged(
    ModalItemNameChangedEvent event,
    Emitter<MenuModalState> emit,
  ) async {
    if (state is MenuModalLoadedState) {
      final currentState = state as MenuModalLoadedState;

      emit(
        MenuModalLoadedState(
          mealTypes: currentState.mealTypes,
          itemName: event.itemName,
          selectedItem: currentState.selectedItem,
          itemImageFile: currentState.itemImageFile,
          itemImageUrl: currentState.itemImageUrl,
        ),
      );
    }
  }
}
