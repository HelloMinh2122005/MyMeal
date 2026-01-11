class FoodDetailsModel {
  final int id;
  final String name;
  final String imageUrl;
  final int typeId;
  final String typeName;

  FoodDetailsModel({
    required this.id,
    required this.name,
    required this.typeId,
    required this.typeName,
    required this.imageUrl,
  });

  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    return FoodDetailsModel(
      id: json['id'],
      name: json['name'],
      typeId: json['meal_type_id'],
      imageUrl: json['image_url'],
      typeName: json['meal_type_name'],
    );
  }
}
