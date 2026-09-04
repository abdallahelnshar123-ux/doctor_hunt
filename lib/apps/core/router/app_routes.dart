import 'package:doctor_hunt/apps/features/admin_main_screen/presentation/screens/admin_main_screen.dart';
import 'package:doctor_hunt/apps/features/appointment_screen/presentation/screens/appointment_screen.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/patient_login_screen.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/register_screen.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/doctor_details_screen/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/find_doctors_screen/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/admin_login_screen.dart';
import '../../features/main_screen/presentation/screens/main_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<AdminLoginRoute>(path: '/admin_login')
class AdminLoginRoute extends GoRouteData with $AdminLoginRoute {
  const AdminLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminLoginScreen();
  }
}

@TypedGoRoute<PatientLoginRoute>(path: '/patient_login')
class PatientLoginRoute extends GoRouteData with $PatientLoginRoute {
  const PatientLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientLoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(path: '/')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

@TypedGoRoute<MainRoute>(path: '/main')
class MainRoute extends GoRouteData with $MainRoute {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}

@TypedGoRoute<AdminMainRoute>(path: '/admin_main')
class AdminMainRoute extends GoRouteData with $AdminMainRoute {
  const AdminMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminMainScreen();
  }
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
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

@TypedGoRoute<AppointmentRoute>(path: '/appointment')
class AppointmentRoute extends GoRouteData with $AppointmentRoute {
  const AppointmentRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentScreen();
  }
}

final appRouter = GoRouter(routes: $appRoutes);
