import 'package:my_flutter_app/application/entities/type_model.dart';
import 'package:my_flutter_app/application/repositories/interface_type_repository.dart';
import 'package:my_flutter_app/core/database/app_database.dart';

class TypeRepository implements InterfaceTypeRepository {
  final AppDatabase database;

  TypeRepository(this.database);

  @override
  Future<List<TypeModel>> fetchAllTypes() async {
    try {
      final mealTypes = await database.select(database.mealTypes).get();

      return mealTypes
          .map((mealType) => TypeModel(id: mealType.id, name: mealType.name))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch types: $e');
    }
  }

  @override
  Future<TypeModel> fetchTypeById(int id) async {
    try {
      final mealType = await (database.select(
        database.mealTypes,
      )..where((t) => t.id.equals(id))).getSingle();

      return TypeModel(id: mealType.id, name: mealType.name);
    } catch (e) {
      throw Exception('Type not found: $e');
    }
  }
}
