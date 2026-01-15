class FoodModelItem {
  final int id;
  final String name;
  final String imageUrl;
  final String typeName;

  FoodModelItem({
    required this.id,
    required this.name,
    required this.typeName,
    required this.imageUrl,
  });

  factory FoodModelItem.fromJson(Map<String, dynamic> json) {
    return FoodModelItem(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      typeName: json['meal_type_name'],
    );
  }
}
