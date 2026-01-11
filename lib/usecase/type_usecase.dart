import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/type_model.dart';

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
}
