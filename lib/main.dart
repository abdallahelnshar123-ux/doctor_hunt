import 'package:doctor_hunt/apps/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'apps/core/router/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      themeMode: .light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
