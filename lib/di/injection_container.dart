import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/application/repositories/interface_food_repository.dart';
import 'package:my_flutter_app/application/repositories/interface_type_repository.dart';
import 'package:my_flutter_app/core/database/app_database.dart';
import 'package:my_flutter_app/domain/repositories/food_repository.dart';
import 'package:my_flutter_app/domain/repositories/type_repository.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_bloc.dart';
import 'package:my_flutter_app/presentation/screens/random/bloc/random_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../application/usecase/food_usecase.dart';
import '../application/usecase/type_usecase.dart';
import '../core/services/media_service.dart';
import '../core/services/impl/media_service_impl.dart';

List<SingleChildWidget> getProviders() {
  final mediaService = MediaServiceImpl();
  final database = AppDatabase();

  return [
    // Register database
    Provider<AppDatabase>.value(value: database),

    // Register interfaces with concrete implementations
    Provider<InterfaceFoodRepository>(
      create: (context) => FoodRepository(context.read<AppDatabase>()),
    ),
    Provider<InterfaceTypeRepository>(
      create: (context) => TypeRepository(context.read<AppDatabase>()),
    ),

    Provider<FoodUsecase>(
      create: (context) =>
          FoodUsecase(foodRepository: context.read<InterfaceFoodRepository>()),
    ),
    Provider<TypeUsecase>(
      create: (context) =>
          TypeUsecase(typeRepository: context.read<InterfaceTypeRepository>()),
    ),

    Provider<MediaService>.value(value: mediaService),

    // Create BlocProviders with lazy initialization
    BlocProvider<MenuBloc>(
      create: (context) => MenuBloc(
        foodUsecase: context.read<FoodUsecase>(),
        typeUsecase: context.read<TypeUsecase>(),
      ),
      lazy: false, // Initialize immediately since it's used in menu screen
    ),

    BlocProvider<RandomBloc>(
      create: (context) => RandomBloc(
        foodUsecase: context.read<FoodUsecase>(),
        typeUsecase: context.read<TypeUsecase>(),
      ),
      lazy: false, // Initialize immediately since it's used in random screen
    ),
  ];
}
