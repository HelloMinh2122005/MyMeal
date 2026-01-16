import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/application/entities/type_model.dart';

abstract class MenuModalState extends Equatable {}

class MenuModalInitialState extends MenuModalState {
  @override
  List<Object?> get props => [];
}

class MenuModalLoadingState extends MenuModalState {
  @override
  List<Object?> get props => [];
}

class MenuModalErrorState extends MenuModalState {
  final String errorMessage;

  MenuModalErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class MenuModalLoadedState extends MenuModalState {
  final List<TypeModel> mealTypes;
  final String itemName; // should be null if adding new item
  final TypeModel selectedItem;
  final String? itemImageUrl; // Old image URL (if editing existing item)
  final XFile?
  itemImageFile; // Image of the selected item (new one, if update) or null (if add new)

  MenuModalLoadedState({
    this.mealTypes = const [],
    this.itemName = '',
    this.itemImageUrl,
    required this.selectedItem,
    this.itemImageFile,
  });

  @override
  List<Object?> get props => [
    mealTypes,
    itemName,
    itemImageUrl,
    selectedItem,
    itemImageFile,
  ];
}

class MenuNewImageSelectedState extends MenuModalState {
  final TypeModel selectedItem;

  MenuNewImageSelectedState({required this.selectedItem});

  @override
  List<Object?> get props => [selectedItem];
}

class MenuSucessState extends MenuModalState {
  @override
  List<Object?> get props => [];
}
