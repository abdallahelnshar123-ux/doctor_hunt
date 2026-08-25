import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp.router(
        theme: AppTheme.lightTheme,
        themeMode: .light,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
