import 'package:image_picker/image_picker.dart';

abstract class MenuModalEvent {}

class LoadedModalStarted extends MenuModalEvent {
  final int? foodId;

  LoadedModalStarted({this.foodId});
}

class MealTypeSelected extends MenuModalEvent {
  final int? typeId;

  MealTypeSelected({this.typeId});
}

class ConfirmSelected extends MenuModalEvent {
  int? id;
  final String name;
  final int typeId;

  ConfirmSelected({this.id, required this.name, required this.typeId});

  XFile? get itemImageFile => null;
}

class ClosedSelected extends MenuModalEvent {}

class ModalSelectedMealTypeChanged extends MenuModalEvent {
  final int? selectedMealTypeId;

  ModalSelectedMealTypeChanged({this.selectedMealTypeId});
}

class ModalImageSelected extends MenuModalEvent {
  final XFile? imageFile;

  ModalImageSelected({this.imageFile});
}
