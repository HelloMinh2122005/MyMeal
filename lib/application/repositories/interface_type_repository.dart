import 'package:my_flutter_app/application/entities/type_model.dart';

abstract class InterfaceTypeRepository {
  Future<List<TypeModel>> fetchAllTypes();
  Future<TypeModel> fetchTypeById(int id);
}
