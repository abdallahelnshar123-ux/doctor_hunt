import 'package:doctor_hunt/apps/features/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/register_screen.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/doctor_details_screen/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/find_doctors_screen/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/home_screen/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(path: '/home')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: '/register')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<OnboardingRoute>(path: '/')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnboardingScreen();
  }
}

@TypedGoRoute<ChooseRoleRoute>(path: '/choose_role')
class ChooseRoleRoute extends GoRouteData with $ChooseRoleRoute {
  const ChooseRoleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChooseRoleScreen();
  }
}

@TypedGoRoute<FindDoctorRoute>(path: '/fine_doctor')
class FindDoctorRoute extends GoRouteData with $FindDoctorRoute {
  const FindDoctorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FindDoctorsScreen();
  }
}

@TypedGoRoute<DoctorDetailsRoute>(path: '/doctor_details')
class DoctorDetailsRoute extends GoRouteData with $DoctorDetailsRoute {
  const DoctorDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DoctorDetailsScreen();
  }
}
