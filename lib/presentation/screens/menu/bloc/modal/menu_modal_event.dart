import 'package:image_picker/image_picker.dart';

abstract class MenuModalEvent {}

class LoadedModalStartedEvent extends MenuModalEvent {
  final int? foodId;

  LoadedModalStartedEvent({this.foodId});
}

class MealTypeSelectedEvent extends MenuModalEvent {
  final int? typeId;

  MealTypeSelectedEvent({this.typeId});
}

class ImageSelectedEvent extends MenuModalEvent {
  final XFile? imageFile;

  ImageSelectedEvent({this.imageFile});
}

class ImageRemovedEvent extends MenuModalEvent {}

class ConfirmSelectedEvent extends MenuModalEvent {
  int? id; // null if adding new item
  final String name;
  final int typeId;
  final XFile? itemImageFile; // null if old image is kept

  ConfirmSelectedEvent({
    this.id,
    required this.name,
    required this.typeId,
    this.itemImageFile,
  });
}

class ModalSelectedMealTypeChangedEvent extends MenuModalEvent {
  final int? selectedMealTypeId;

  ModalSelectedMealTypeChangedEvent({this.selectedMealTypeId});
}

class ModalImageSelectedEvent extends MenuModalEvent {}

class ModalItemNameChangedEvent extends MenuModalEvent {
  final String itemName;

  ModalItemNameChangedEvent({required this.itemName});
}
