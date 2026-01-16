import 'package:my_flutter_app/application/repositories/interface_type_repository.dart';

import '../entities/type_model.dart';

class TypeUsecase {
  final InterfaceTypeRepository typeRepository;

  TypeUsecase({required this.typeRepository});

  Future<List<TypeModel>> fetchAllTypes() async {
    try {
      return await typeRepository.fetchAllTypes();
    } catch (e) {
      throw Exception('Failed to fetch types: $e');
    }
  }

  Future<TypeModel> fetchTypeById(int id) async {
    try {
      return await typeRepository.fetchTypeById(id);
    } catch (e) {
      throw Exception('Failed to fetch type by id: $e');
    }
  }
}
