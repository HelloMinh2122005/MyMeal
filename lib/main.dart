import 'package:flutter/material.dart';
import 'presentation/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'usecase/food_usecase.dart';
import 'usecase/type_usecase.dart';
import 'presentation/screens/menu/provider/menu_provider.dart';
import 'core/config/cloudinary_config.dart';
import 'core/services/media_service.dart';
import 'core/services/impl/media_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cloudinaryConfig = CloudinaryConfig();
  await cloudinaryConfig.init();

  final mediaService = MediaServiceImpl(cloudinaryConfig);

  runApp(
    MultiProvider(
      providers: [
        // Create use case first
        Provider<FoodUsecase>(create: (_) => FoodUsecase()),
        Provider<TypeUsecase>(create: (_) => TypeUsecase()),

        Provider<MediaService>.value(value: mediaService),

        // Create Provider, then inject use case to provider
        ChangeNotifierProvider<MenuProvider>(
          create: (context) => MenuProvider(
            foodUsecase: context.read<FoodUsecase>(),
            typeUsecase: context.read<TypeUsecase>(),
            mediaService: context.read<MediaService>(),
          ),
        ),
      ],
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: Home()),
    ),
  );
}
