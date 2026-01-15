import 'dart:convert';

import 'package:flutter/services.dart';

import '../entities/type_model.dart';

class TypeUsecase {
  Future<List<TypeModel>> fetchAllTypes() async {
    List<TypeModel> types = [];
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    types = (data['meal_types'] as List)
        .map((item) => TypeModel.fromJson(item))
        .toList();

    return types;
  }

  Future<TypeModel> fetchTypeById(int id) async {
    TypeModel typeModel;
    final String response = await rootBundle.loadString(
      'assets/mock_data.json',
    );
    final data = json.decode(response);
    final item = (data['meal_types'] as List).firstWhere(
      (item) => item['id'] == id,
      orElse: () => null,
    );
    if (item != null) {
      typeModel = TypeModel.fromJson(item);
    } else {
      throw Exception('Type not found');
    }
    return typeModel;
  }
}
