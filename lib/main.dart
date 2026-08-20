import 'package:doctor_hunt/apps/core/utils/app_routes.dart';
import 'package:doctor_hunt/apps/core/utils/app_theme.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/register_screen.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/doctor_details_screen/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/find_doctors_screen/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/home_screen/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        theme: AppTheme.lightTheme,
        themeMode: .light,
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(
          initialLocation: '/${AppRoutes.doctorDetailsRouteName}',
          routes: [
            GoRoute(
              path: '/${AppRoutes.onboardingRouteName}',
              name: AppRoutes.loginRouteName,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/${AppRoutes.registerRouteName}',
              name: AppRoutes.registerRouteName,
              builder: (context, state) => const RegisterScreen(),
            ),
            GoRoute(
              path: '/${AppRoutes.onboardingRouteName}',
              name: AppRoutes.onboardingRouteName,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => OnboardingViewModel(),
                child: const OnboardingScreen(),
              ),
            ),
            GoRoute(
              path: '/${AppRoutes.chooseRoleRouteName}',
              name: AppRoutes.chooseRoleRouteName,
              builder: (context, state) => const ChooseRoleScreen(),
            ),
            GoRoute(
              path: '/${AppRoutes.homeScreenRouteName}',
              name: AppRoutes.homeScreenRouteName,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/${AppRoutes.findDoctorsScreenRouteName}',
              name: AppRoutes.findDoctorsScreenRouteName,
              builder: (context, state) => const FindDoctorsScreen(),
            ),
            GoRoute(
              path: '/${AppRoutes.doctorDetailsRouteName}',
              name: AppRoutes.doctorDetailsRouteName,
              builder: (context, state) => const DoctorDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
