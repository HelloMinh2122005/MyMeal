import 'package:flutter/material.dart';
import 'presentation/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'usecase/food_usecase.dart';
import 'usecase/type_usecase.dart';
import 'presentation/screens/menu/provider/menu_provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      // Create use case first
      Provider<FoodUsecase>(create: (_) => FoodUsecase()),
      Provider<TypeUsecase>(create: (_) => TypeUsecase()),

      // Create Provider, then inject use case to provider
      ChangeNotifierProvider<MenuProvider>(
        create: (context) => MenuProvider(
          // context.read to get instances of FoodUsecase and TypeUsecase that were created above
          foodUsecase: context.read<FoodUsecase>(),
          typeUsecase: context.read<TypeUsecase>(),
        ),
      ),
    ],
    child: const MaterialApp(home: Home()),
  ),
);
