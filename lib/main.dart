import 'package:flutter/material.dart';
import 'package:my_flutter_app/core/database/app_database.dart';
import 'package:my_flutter_app/core/database/dummy/app_dummy.dart';
import 'package:provider/provider.dart';
import 'config/router/app_router.dart';
import 'di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final dummy = AppDummy(database);

  // Check if data exists
  if (!await dummy.hasData()) {
    // Seed the database
    await dummy.seedData();
  }

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    ),
  );
}
