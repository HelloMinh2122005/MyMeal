import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/models/type_model.dart';

class MenuModalState extends Equatable {
  final List<TypeModel> mealTypes;
  final String? itemName;
  final String? errorMessage;
  final TypeModel? selectedItem;
  final XFile?
  itemImageFile; // For local pending image (select but not yet confirm to upload)
  final String? itemImageUrl; // For uploaded image
  final bool isLoading;

  List<TypeModel> get types => mealTypes;
  String? get name => itemName;
  String? get error => errorMessage;
  TypeModel? get selectedMealType => selectedItem;
  XFile? get imageFile => itemImageFile;
  bool get loading => isLoading;
  String? get imageUrl => itemImageUrl;

  const MenuModalState({
    this.mealTypes = const [],
    this.itemName = '',
    this.errorMessage,
    this.itemImageUrl,
    this.selectedItem,
    this.itemImageFile,
    this.isLoading = true,
  });

  MenuModalState copyWith({
    List<TypeModel>? mealTypes,
    TypeModel? selectedItem,
    String? itemName,
    int? itemMealId,
    String? itemMealType,
    String? itemImageUrl,
    bool? isLoading,
    String? errorMessage,
    XFile? itemImageFile,
  }) {
    return MenuModalState(
      mealTypes: mealTypes ?? this.mealTypes,
      itemName: itemName ?? this.itemName,
      itemImageFile: itemImageFile ?? this.itemImageFile,
      itemImageUrl: itemImageUrl ?? this.itemImageUrl,
      isLoading: isLoading ?? this.isLoading,
      selectedItem: selectedItem ?? this.selectedItem,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    mealTypes,
    itemName,
    itemImageFile,
    itemImageUrl,
    isLoading,
    selectedItem,
    errorMessage,
  ];
}
