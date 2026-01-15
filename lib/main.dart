import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/router/app_router.dart';
import 'di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
