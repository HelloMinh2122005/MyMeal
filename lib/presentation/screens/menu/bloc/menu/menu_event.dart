abstract class MenuEvent {}

class MenuLoadedStarted extends MenuEvent {}

class MenuFilterChanged extends MenuEvent {
  final int? typeId;
  final String? keyword;

  MenuFilterChanged({this.typeId, this.keyword});
}

class MenuDeletedFoodItem extends MenuEvent {
  final int foodId;

  MenuDeletedFoodItem({required this.foodId});
}

class MenuFetchFoodById extends MenuEvent {
  final int foodId;

  MenuFetchFoodById({required this.foodId});
}

class AddNewFoodItem extends MenuEvent {}

class EditFoodItem extends MenuEvent {
  final int foodId;

  EditFoodItem({required this.foodId});
}
