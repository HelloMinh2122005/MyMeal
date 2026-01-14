import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_bloc.dart';
import 'package:my_flutter_app/presentation/screens/random/bloc/random_bloc.dart';
import 'package:provider/provider.dart';
import 'router/app_router.dart';
import 'usecase/food_usecase.dart';
import 'usecase/type_usecase.dart';
import 'core/services/media_service.dart';
import 'core/services/impl/media_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final mediaService = MediaServiceImpl();

  runApp(
    MultiProvider(
      providers: [
        // Create use case as singletons (they should be reused across the app)
        Provider<FoodUsecase>(create: (_) => FoodUsecase()),
        Provider<TypeUsecase>(create: (_) => TypeUsecase()),

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
          lazy:
              false, // Initialize immediately since it's used in random screen
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    ),
  );
}
