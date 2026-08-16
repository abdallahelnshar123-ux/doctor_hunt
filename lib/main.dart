import 'package:doctor_hunt/apps/core/utils/app_routes.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(
          initialLocation: '/${AppRoutes.registerRouteName}',
          routes: [
            GoRoute(
              path: '/${AppRoutes.loginRouteName}',
              name: AppRoutes.loginRouteName,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/${AppRoutes.registerRouteName}',
              name: AppRoutes.registerRouteName,
              builder: (context, state) => const RegisterScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
